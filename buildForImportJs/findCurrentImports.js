Object.defineProperty(exports, "__esModule", {
  value: true
});
exports['default'] = findCurrentImports;

var _Configuration = require('./Configuration');

var _Configuration2 = _interopRequireDefault(_Configuration);

var _ImportStatement = require('./ImportStatement');

var _ImportStatement2 = _interopRequireDefault(_ImportStatement);

var _ImportStatements = require('./ImportStatements');

var _ImportStatements2 = _interopRequireDefault(_ImportStatements);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

function convertToImportStatement(node) {
  if (node.type === 'ImportDeclaration') {
    var defaultSpecifier = node.specifiers.find(function (spec) {
      return spec.type === 'ImportDefaultSpecifier' || spec.type === 'ImportNamespaceSpecifier';
    });

    var namedImports = node.specifiers.map(function (spec) {
      if (spec.type !== 'ImportSpecifier') {
        return undefined;
      }
      var isType = node.importKind === 'type' || spec.importKind === 'type';
      if (spec.local.name !== spec.imported.name) {
        return {
          localName: spec.local.name,
          importedName: spec.imported.name,
          isType
        };
      }
      return {
        localName: spec.local.name,
        isType
      };
    }).filter(Boolean);

    return new _ImportStatement2['default']({
      declarationKeyword: 'import',
      defaultImport: defaultSpecifier ? defaultSpecifier.local.name : undefined,
      hasSideEffects: node.specifiers.length === 0,
      namedImports,
      areOnlyTypes: node.importKind === 'type',
      path: node.source.value
    });
  }

  if (node.type === 'ExpressionStatement') {
    if (!node.expression.callee) {
      return undefined;
    }
    if (node.expression.callee.name !== 'require') {
      return undefined;
    }

    if (node.expression.arguments.length !== 1) {
      return undefined;
    }

    return new _ImportStatement2['default']({
      hasSideEffects: true,
      importFunction: 'require',
      path: node.expression.arguments[0].value
    });
  }

  if (node.type === 'VariableDeclaration') {
    if (!node.declarations || node.declarations.length > 1) {
      return undefined;
    }

    var declaration = node.declarations[0];
    if (!declaration.init) {
      // e.g. `let foo;`
      return undefined;
    }
    if (declaration.init.type !== 'CallExpression') {
      return undefined;
    }

    if (declaration.init.arguments.length !== 1) {
      return undefined;
    }

    if (declaration.init.arguments[0].type !== 'StringLiteral') {
      return undefined;
    }

    var defaultImport = declaration.id.type === 'Identifier' ? declaration.id.name : undefined;

    var _namedImports = declaration.id.type === 'ObjectPattern' ? declaration.id.properties.map(function (p) {
      return {
        localName: p.value.name
      };
    }) : undefined;

    return new _ImportStatement2['default']({
      declarationKeyword: node.kind,
      defaultImport,
      hasSideEffects: false,
      importFunction: declaration.init.callee.name,
      namedImports: _namedImports,
      path: declaration.init.arguments[0].value
    });
  }
  return undefined;
}

function findCurrentImports(config, currentFileContent, ast) {
  var result = {
    imports: new _ImportStatements2['default'](config),
    range: {
      start: ast.program.loc.end.line - 1,
      end: 0
    }
  };

  var done = false;
  ast.program.body.forEach(function (node, index) {
    if (done) {
      return;
    }
    result.range.start = Math.min(result.range.start, node.loc.start.line - 1);

    var importStatement = convertToImportStatement(node);
    if (!importStatement) {
      // We've reached the end of the imports block
      done = true;
      return;
    }

    // If groupImports and sortImports are both disabled, we will preserve
    // whitespace and comments, in order to reduce changes made by `fix`.
    // We save leading content for all imports, except the first one.
    if (!result.imports.empty() && !config.get('groupImports') && !config.get('sortImports') && index > 0) {
      var previousNodeEnd = ast.program.body[index - 1].end;

      // Advance past the end of the line
      var newlineIndex = currentFileContent.indexOf('\n', previousNodeEnd);
      if (newlineIndex !== -1) {
        previousNodeEnd += newlineIndex - previousNodeEnd + 1;
      }

      importStatement.leadingContent = currentFileContent.slice(previousNodeEnd, node.start);
    }

    importStatement.originalImportString = currentFileContent.slice(node.start, node.end);
    result.imports.push(importStatement);
    result.range.end = node.loc.end.line;
  });

  if (!result.range.end) {
    result.range.end = result.range.start;
  }
  return result;
}
module.exports = exports['default'];