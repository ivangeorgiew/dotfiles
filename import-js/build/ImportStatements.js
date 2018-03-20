Object.defineProperty(exports, "__esModule", {
  value: true
});

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

// Class that sorts ImportStatements as they are pushed in


var _flattenDeep = require('lodash/flattenDeep');

var _flattenDeep2 = _interopRequireDefault(_flattenDeep);

var _partition = require('lodash/partition');

var _partition2 = _interopRequireDefault(_partition);

var _sortBy = require('lodash/sortBy');

var _sortBy2 = _interopRequireDefault(_sortBy);

var _uniqBy = require('lodash/uniqBy');

var _uniqBy2 = _interopRequireDefault(_uniqBy);

var _Configuration = require('./Configuration');

var _Configuration2 = _interopRequireDefault(_Configuration);

var _ImportStatement = require('./ImportStatement');

var _ImportStatement2 = _interopRequireDefault(_ImportStatement);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var STYLE_SIDE_EFFECT = 'side-effect';
var STYLE_IMPORT = 'import';
var STYLE_CONST = 'const';
var STYLE_VAR = 'var';
var STYLE_CUSTOM = 'custom';

// Order is significant here
var STYLES = Object.freeze([STYLE_SIDE_EFFECT, STYLE_IMPORT, STYLE_CONST, STYLE_VAR, STYLE_CUSTOM]);

var PATH_TYPE_CORE_MODULE = 'core_module';
var PATH_TYPE_PACKAGE = 'package';
var PATH_TYPE_NON_RELATIVE = 'non_relative';
var PATH_TYPE_RELATIVE = 'relative';

// Order is significant here
var PATH_TYPES = Object.freeze([PATH_TYPE_CORE_MODULE, PATH_TYPE_PACKAGE, PATH_TYPE_NON_RELATIVE, PATH_TYPE_RELATIVE]);

var GROUPINGS_ARRAY = Object.freeze((0, _flattenDeep2['default'])(STYLES.map(function (style) {
  return PATH_TYPES.map(function (location) {
    return String(style) + ' ' + String(location);
  });
})));

var GROUPINGS = {};
GROUPINGS_ARRAY.forEach(function (group, index) {
  GROUPINGS[group] = index;
});
Object.freeze(GROUPINGS);

/**
  * Determine import path type (e.g. 'package, 'non-relative', 'relative')
  */
function importStatementPathType(importStatement, packageDependencies, coreModules) {
  if (importStatement.path.startsWith('.')) {
    return PATH_TYPE_RELATIVE;
  }

  if (coreModules.indexOf(importStatement.path) !== -1) {
    return PATH_TYPE_CORE_MODULE;
  }

  // Match if any of the packageDependencies exactly match path or match the
  // start of the path up to a path divider. This is so that imports for
  // modules inside package dependencies end up in the right group
  // (PATH_TYPE_PACKAGE).
  if (Array.from(packageDependencies).some(function (pkg) {
    return importStatement.path === pkg || importStatement.path.startsWith(String(pkg) + '/');
  })) {
    return PATH_TYPE_PACKAGE;
  }

  return PATH_TYPE_NON_RELATIVE;
}

/**
  * Determine import statement style (e.g. 'import', 'const', 'var', or
  * 'custom')
  */
function importStatementStyle(importStatement) {
  if (importStatement.hasSideEffects) {
    return STYLE_SIDE_EFFECT;
  }

  if (importStatement.declarationKeyword === 'import') {
    return STYLE_IMPORT;
  }

  if (importStatement.importFunction === 'require') {
    if (importStatement.declarationKeyword === 'const') {
      return STYLE_CONST;
    }
    if (importStatement.declarationKeyword === 'var') {
      return STYLE_VAR;
    }
  }

  return STYLE_CUSTOM;
}

function importStatementGroupIndex(importStatement, packageDependencies, coreModules) {
  var style = importStatementStyle(importStatement);
  var pathType = importStatementPathType(importStatement, packageDependencies, coreModules);

  return GROUPINGS[String(style) + ' ' + String(pathType)];
}

var ImportStatements = function () {
  function ImportStatements(config) {
    var imports = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

    _classCallCheck(this, ImportStatements);

    this.config = config;
    this.imports = imports;
  }

  _createClass(ImportStatements, [{
    key: 'clone',
    value: function () {
      function clone() {
        return new ImportStatements(this.config, Object.assign({}, this.imports));
      }

      return clone;
    }()

    /**
     * Method added to make it behave like an array.
     */

  }, {
    key: 'forEach',
    value: function () {
      function forEach(callback) {
        var _this = this;

        Object.keys(this.imports).forEach(function (key) {
          callback(_this.imports[key]);
        });
      }

      return forEach;
    }()

    /**
     * Method added to make it behave like an array.
     */

  }, {
    key: 'find',
    value: function () {
      function find(callback) {
        var _this2 = this;

        var key = Object.keys(this.imports).find(function (key) {
          return callback(_this2.imports[key]);
        });
        if (!key) {
          return undefined;
        }
        return this.imports[key];
      }

      return find;
    }()
  }, {
    key: 'push',
    value: function () {
      function push() {
        var _this3 = this;

        for (var _len = arguments.length, importStatements = Array(_len), _key = 0; _key < _len; _key++) {
          importStatements[_key] = arguments[_key];
        }

        importStatements.forEach(function (importStatement) {
          var existingStatement = _this3.imports[importStatement.path];
          if (existingStatement) {
            // Import already exists, so this line is likely one of a named imports
            // pair. Combine it into the same ImportStatement.
            // eslint-disable-next-line no-param-reassign
            importStatement.isChangedNamedImport = true;
            existingStatement.merge(importStatement);
          } else {
            // This is a new import, so we just add it to the hash.
            _this3.imports[importStatement.path] = importStatement;
          }
        });

        return this; // for chaining
      }

      return push;
    }()
  }, {
    key: 'empty',
    value: function () {
      function empty() {
        return this.size() === 0;
      }

      return empty;
    }()
  }, {
    key: 'size',
    value: function () {
      function size() {
        return Object.keys(this.imports).length;
      }

      return size;
    }()
  }, {
    key: 'deleteVariables',
    value: function () {
      function deleteVariables(variableNames) {
        var _this4 = this;

        Object.keys(this.imports).forEach(function (key) {
          var importStatement = _this4.imports[key];
          variableNames.forEach(function (variableName) {
            importStatement.deleteVariable(variableName);
          });
          if (importStatement.isEmpty()) {
            delete _this4.imports[key];
          }
        });

        return this; // for chaining
      }

      return deleteVariables;
    }()

    /**
     * Convert the import statements into an array of strings, with an empty
     * string between each group.
     */

  }, {
    key: 'toArray',
    value: function () {
      function toArray() {
        var _this5 = this;

        var maxLineLength = this.config.get('maxLineLength');
        var tab = this.config.get('tab');

        var strings = [];
        this._toGroups().forEach(function (group) {
          group.forEach(function (importStatement) {
            var importStrings = importStatement.toImportStrings(maxLineLength, tab).map(function (importString) {
              return _this5.config.get('importStatementFormatter', {
                importStatement: importString,
                moduleName: importStatement.path
              });
            });
            strings.push.apply(strings, _toConsumableArray(importStrings));
          });
          // strings.push(''); // Add a blank line between groups.
        });

        // We don't want to include a trailing newline at the end of all the
        // groups here.
        if (strings[strings.length - 1] === '') {
          strings.pop();
        }

        return strings;
      }

      return toArray;
    }()

    /**
     * Sort the import statements by path and group them based on our heuristic
     * of style and path type.
     */

  }, {
    key: '_toGroups',
    value: function () {
      function _toGroups() {
        var _this6 = this;

        var groups = [];

        var importsArray = Object.keys(this.imports).map(function (key) {
          return _this6.imports[key];
        });

        // There's a chance we have duplicate imports (can happen when switching
        // declaration_keyword for instance). By first sorting imports so that new
        // ones are first, then removing duplicates, we guarantee that we delete
        // the old ones that are now redundant.
        var result = (0, _partition2['default'])(importsArray, function (importStatement) {
          return !importStatement.isParsedAndUntouched();
        }).reverse();

        result = (0, _flattenDeep2['default'])(result);

        if (this.config.get('sortImports')) {
          result = (0, _sortBy2['default'])(result, function (is) {
            return is.toNormalized();
          });
        }

        result = (0, _uniqBy2['default'])(result, function (is) {
          return is.toNormalized();
        });

        if (!this.config.get('groupImports')) {
          return [result];
        }

        var packageDependencies = this.config.get('packageDependencies');
        var coreModules = this.config.get('coreModules');
        result.forEach(function (importStatement) {
          // Figure out what group to put this import statement in
          var groupIndex = importStatementGroupIndex(importStatement, packageDependencies, coreModules);

          // Add the import statement to the group
          groups[groupIndex] = groups[groupIndex] || [];
          groups[groupIndex].push(importStatement);
        });

        if (groups.length) {
          groups.filter(Boolean); // compact
        }
        return groups;
      }

      return _toGroups;
    }()
  }]);

  return ImportStatements;
}();

exports['default'] = ImportStatements;
module.exports = exports['default'];