Object.defineProperty(exports, "__esModule", {
  value: true
});

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

var _requireRelative = require('require-relative');

var _requireRelative2 = _interopRequireDefault(_requireRelative);

var _CommandLineEditor = require('./CommandLineEditor');

var _CommandLineEditor2 = _interopRequireDefault(_CommandLineEditor);

var _Configuration = require('./Configuration');

var _Configuration2 = _interopRequireDefault(_Configuration);

var _ImportStatement = require('./ImportStatement');

var _ImportStatement2 = _interopRequireDefault(_ImportStatement);

var _ImportStatements = require('./ImportStatements');

var _ImportStatements2 = _interopRequireDefault(_ImportStatements);

var _JsModule = require('./JsModule');

var _JsModule2 = _interopRequireDefault(_JsModule);

var _findCurrentImports3 = require('./findCurrentImports');

var _findCurrentImports4 = _interopRequireDefault(_findCurrentImports3);

var _findJsModulesFor = require('./findJsModulesFor');

var _findJsModulesFor2 = _interopRequireDefault(_findJsModulesFor);

var _findUndefinedIdentifiers = require('./findUndefinedIdentifiers');

var _findUndefinedIdentifiers2 = _interopRequireDefault(_findUndefinedIdentifiers);

var _findUsedIdentifiers = require('./findUsedIdentifiers');

var _findUsedIdentifiers2 = _interopRequireDefault(_findUsedIdentifiers);

var _parse = require('./parse');

var _parse2 = _interopRequireDefault(_parse);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function fixImportsMessage(removedItems, addedItems) {
  var messageParts = [];

  var firstAdded = addedItems.values().next().value;
  var firstRemoved = removedItems.values().next().value;

  if (addedItems.size === 1 && firstAdded) {
    messageParts.push('Imported ' + String(firstAdded));
  } else if (addedItems.size) {
    messageParts.push('Added ' + String(addedItems.size) + ' imports');
  }

  if (removedItems.size === 1 && firstRemoved) {
    messageParts.push('Removed `' + String(firstRemoved) + '`.');
  } else if (removedItems.size) {
    messageParts.push('Removed ' + String(removedItems.size) + ' imports.');
  }

  if (messageParts.length === 0) {
    return undefined;
  }
  return messageParts.join('. ');
}

function findFilePathFromImports(imports, dirname, variableName) {
  // eslint-disable-next-line no-restricted-syntax
  var importStatement = imports.find(function (is) {
    return is.hasVariable(variableName);
  });

  if (!importStatement) {
    return undefined;
  }

  try {
    return _requireRelative2['default'].resolve(importStatement.path, dirname);
  } catch (e) {
    // it's expected that we can't resolve certain paths.
  }
  return undefined;
}

var Importer = function () {
  function Importer(lines, pathToCurrentFile) {
    var workingDirectory = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : process.cwd();

    _classCallCheck(this, Importer);

    this.pathToCurrentFile = pathToCurrentFile || '';
    this.editor = new _CommandLineEditor2['default'](lines);
    this.config = new _Configuration2['default'](this.pathToCurrentFile, workingDirectory);
    this.workingDirectory = workingDirectory;

    this.messages = Array.from(this.config.messages);
    this.unresolvedImports = {};
    try {
      this.ast = (0, _parse2['default'])(this.editor.currentFileContent());
    } catch (e) {
      if (e instanceof SyntaxError) {
        this.message('SyntaxError: ' + String(e.message));
        this.ast = (0, _parse2['default'])('');
      } else {
        throw new Error(e);
      }
    }
  }

  _createClass(Importer, [{
    key: 'results',
    value: function () {
      function results() {
        return {
          messages: this.messages, // array
          fileContent: this.editor.currentFileContent(), // string
          unresolvedImports: this.unresolvedImports // object
        };
      }

      return results;
    }()

    /**
     * Imports one variable
     */

  }, {
    key: 'import',
    value: function () {
      function _import(variableName) {
        var _this = this;

        return new Promise(function (resolve, reject) {
          _this.findOneJsModule(variableName).then(function (jsModule) {
            if (!jsModule) {
              if (!Object.keys(_this.unresolvedImports).length) {
                _this.message('No JS module to import for `' + String(variableName) + '`');
              }
              resolve(_this.results());
              return;
            }

            var imported = jsModule.hasNamedExports ? '{ ' + String(variableName) + ' }' : variableName;

            _this.message('Imported ' + String(imported) + ' from \'' + String(jsModule.importPath) + '\'');

            var oldImports = _this.findCurrentImports();
            var importStatement = jsModule.toImportStatement(_this.config);
            oldImports.imports.push(importStatement);
            _this.replaceImports(oldImports.range, oldImports.imports);

            resolve(_this.results());
          })['catch'](function (error) {
            reject(error);
          });
        });
      }

      return _import;
    }()

    /**
     * Searches for an export
     */

  }, {
    key: 'search',
    value: function () {
      function search(variableName) {
        var _this2 = this;

        return (0, _findJsModulesFor2['default'])(this.config, variableName, { search: true }).then(function (modules) {
          return {
            modules,
            messages: _this2.messages
          };
        });
      }

      return search;
    }()
  }, {
    key: 'goto',
    value: function () {
      function goto(variableName) {
        var _this3 = this;

        var _findCurrentImports2 = this.findCurrentImports(),
            imports = _findCurrentImports2.imports;

        var filePath = findFilePathFromImports(imports, _path2['default'].dirname(this.pathToCurrentFile), variableName);
        if (filePath) {
          return Promise.resolve(Object.assign({
            goto: filePath
          }, this.results()));
        }

        return new Promise(function (resolve, reject) {
          (0, _findJsModulesFor2['default'])(_this3.config, variableName).then(function (jsModules) {
            if (!jsModules.length) {
              // The current word is not mappable to one of the JS modules that we
              // found. This can happen if the user does not select one from the list.
              // We have nothing to go to, so we return early.
              _this3.message('No JS module found for `' + String(variableName) + '`');
              resolve(_this3.results());
              return;
            }

            var filePath = jsModules[0].resolvedFilePath(_this3.pathToCurrentFile, _this3.workingDirectory);
            var results = _this3.results();
            results.goto = _path2['default'].isAbsolute(filePath) ? filePath : _path2['default'].join(_this3.workingDirectory, filePath);
            resolve(results);
          })['catch'](function (error) {
            reject(error);
          });
        });
      }

      return goto;
    }()

    // Removes unused imports and adds imports for undefined variables

  }, {
    key: 'fixImports',
    value: function () {
      function fixImports() {
        var _this4 = this;

        var undefinedVariables = (0, _findUndefinedIdentifiers2['default'])(this.ast, this.config.get('globals'));
        var usedVariables = (0, _findUsedIdentifiers2['default'])(this.ast);
        var oldImports = this.findCurrentImports();
        var newImports = oldImports.imports.clone();

        var unusedImportVariables = new Set();
        oldImports.imports.forEach(function (importStatement) {
          importStatement.variables().forEach(function (variable) {
            if (!usedVariables.has(variable)) {
              unusedImportVariables.add(variable);
            }
          });
        });
        newImports.deleteVariables(unusedImportVariables);

        var addedItems = new Set(this.injectSideEffectImports(newImports));

        return new Promise(function (resolve, reject) {
          var allPromises = [];
          undefinedVariables.forEach(function (variable) {
            allPromises.push(_this4.findOneJsModule(variable));
          });
          Promise.all(allPromises).then(function (results) {
            results.forEach(function (jsModule) {
              if (!jsModule) {
                return;
              }
              var imported = jsModule.hasNamedExports ? '{ ' + String(jsModule.variableName) + ' }' : jsModule.variableName;
              addedItems.add(String(imported) + ' from \'' + String(jsModule.importPath) + '\'');
              newImports.push(jsModule.toImportStatement(_this4.config));
            });

            _this4.replaceImports(oldImports.range, newImports);

            var message = fixImportsMessage(unusedImportVariables, addedItems);
            if (message) {
              _this4.message(message);
            }

            resolve(_this4.results());
          })['catch'](function (error) {
            reject(error);
          });
        });
      }

      return fixImports;
    }()
  }, {
    key: 'addImports',
    value: function () {
      function addImports(imports) {
        var _this5 = this;

        return new Promise(function (resolve, reject) {
          var oldImports = _this5.findCurrentImports();
          var newImports = oldImports.imports.clone();

          var variables = Object.keys(imports);
          var promises = variables.map(function (variableName) {
            return (0, _findJsModulesFor2['default'])(_this5.config, variableName).then(function (jsModules) {
              var importData = imports[variableName];
              var dataIsObject = typeof importData === 'object';
              var importPath = dataIsObject ? importData.importPath : importData;
              var hasNamedExports = dataIsObject ? importData.isNamedExport : undefined;

              var foundModule = jsModules.find(function (jsModule) {
                return jsModule.importPath === importPath && (hasNamedExports === undefined || jsModule.hasNamedExports === hasNamedExports);
              });

              if (foundModule) {
                newImports.push(foundModule.toImportStatement(_this5.config));
              } else {
                newImports.push(new _JsModule2['default']({
                  importPath,
                  variableName,
                  hasNamedExports
                }).toImportStatement(_this5.config));
              }
            })['catch'](reject);
          });

          Promise.all(promises).then(function () {
            if (variables.length === 1) {
              _this5.message('Added import for `' + String(variables[0]) + '`');
            } else {
              _this5.message('Added ' + String(variables.length) + ' imports');
            }

            _this5.replaceImports(oldImports.range, newImports);

            resolve(_this5.results());
          });
        });
      }

      return addImports;
    }()
  }, {
    key: 'rewriteImports',
    value: function () {
      function rewriteImports() {
        var _this6 = this;

        var oldImports = this.findCurrentImports();
        var newImports = new _ImportStatements2['default'](this.config);

        return new Promise(function (resolve, reject) {
          var variables = [];
          var sideEffectOnlyImports = [];
          oldImports.imports.forEach(function (imp) {
            if (imp.variables().length) {
              variables.push.apply(variables, _toConsumableArray(imp.variables()));
            } else if (imp.hasSideEffects) {
              // side-effect imports don't have variable names. Tuck them away and just pass
              // them through to the end of this operation.
              sideEffectOnlyImports.push(imp);
            }
          });
          var promises = variables.map(function (variable) {
            return (0, _findJsModulesFor2['default'])(_this6.config, variable);
          });

          Promise.all(promises).then(function (results) {
            results.forEach(function (jsModules) {
              if (!jsModules.length) {
                return;
              }

              var variableName = jsModules[0].variableName;

              var jsModule = _this6.resolveModuleUsingCurrentImports(jsModules, variableName) || _this6.resolveOneJsModule(jsModules, variableName);

              if (!jsModule) {
                return;
              }

              newImports.push(jsModule.toImportStatement(_this6.config));
            });

            newImports.push.apply(newImports, sideEffectOnlyImports);

            _this6.replaceImports(oldImports.range, newImports);
            resolve(_this6.results());
          })['catch'](function (error) {
            reject(error);
          });
        });
      }

      return rewriteImports;
    }()
  }, {
    key: 'message',
    value: function () {
      function message(str) {
        this.messages.push(str);
      }

      return message;
    }()
  }, {
    key: 'findOneJsModule',
    value: function () {
      function findOneJsModule(variableName) {
        var _this7 = this;

        return new Promise(function (resolve, reject) {
          (0, _findJsModulesFor2['default'])(_this7.config, variableName).then(function (jsModules) {
            if (!jsModules.length) {
              resolve(null);
              return;
            }
            resolve(_this7.resolveOneJsModule(jsModules, variableName));
          })['catch'](function (error) {
            reject(error);
          });
        });
      }

      return findOneJsModule;
    }()
  }, {
    key: 'replaceImports',
    value: function () {
      function replaceImports(oldImportsRange, newImports) {
        var _this8 = this;

        var importStrings = newImports.toArray();

        // Ensure that there is a blank line after the block of all imports
        if (importStrings.length && this.editor.get(oldImportsRange.end) !== '') {
          this.editor.insertBefore(oldImportsRange.end, '');
        }

        // Delete old imports, then add the modified list back in.
        for (var i = oldImportsRange.end - 1; i >= oldImportsRange.start; i -= 1) {
          this.editor.remove(i);
        }

        if (importStrings.length === 0 && this.editor.get(oldImportsRange.start) === '') {
          // We have no newlines to write back to the file. Clearing out potential
          // whitespace where the imports used to be leaves the file in a better
          // state.
          this.editor.remove(oldImportsRange.start);
          return;
        }

        importStrings.reverse().forEach(function (importString) {
          // We need to add each line individually because the Vim buffer will
          // convert newline characters to `~@`.
          if (importString.indexOf('\n') !== -1) {
            importString.split('\n').reverse().forEach(function (line) {
              _this8.editor.insertBefore(oldImportsRange.start, line);
            });
          } else {
            _this8.editor.insertBefore(oldImportsRange.start, importString);
          }
        });

        while (this.editor.get(0) === '') {
          this.editor.remove(0);
        }
      }

      return replaceImports;
    }()
  }, {
    key: 'findCurrentImports',
    value: function () {
      function findCurrentImports() {
        return (0, _findCurrentImports4['default'])(this.config, this.editor.currentFileContent(), this.ast);
      }

      return findCurrentImports;
    }()
  }, {
    key: 'resolveOneJsModule',
    value: function () {
      function resolveOneJsModule(jsModules, variableName) {
        var _this9 = this;

        if (jsModules.length === 1) {
          var jsModule = jsModules[0];
          return jsModule;
        }

        if (!jsModules.length) {
          return undefined;
        }

        var countSeparators = function () {
          function countSeparators(importPath) {
            var separators = importPath.match(/\//g);
            return separators ? separators.length : 0;
          }

          return countSeparators;
        }();

        this.unresolvedImports[variableName] = jsModules.map(function (jsModule) {
          return {
            displayName: jsModule.toImportStatement(_this9.config).toImportStrings(Infinity, '  ')[0],
            importPath: jsModule.importPath, // backward compatibility
            data: {
              importPath: jsModule.importPath,
              filePath: jsModule.resolvedFilePath(_this9.pathToCurrentFile, _this9.workingDirectory),
              isNamedExport: jsModule.hasNamedExports
            }
          };
        }).sort(function (a, b) {
          return countSeparators(a.data.importPath) - countSeparators(b.data.importPath);
        });

        return undefined;
      }

      return resolveOneJsModule;
    }()
  }, {
    key: 'resolveModuleUsingCurrentImports',
    value: function () {
      function resolveModuleUsingCurrentImports(jsModules, variableName) {
        var _this10 = this;

        if (jsModules.length === 1) {
          return jsModules[0];
        }

        // Look at the current imports and grab what is already imported for the
        // variable.
        var matchingImportStatement = this.findCurrentImports().imports.find(function (ist) {
          return ist.hasVariable(variableName);
        });

        if (!matchingImportStatement) {
          return undefined;
        }

        if (jsModules.length > 0) {
          // Look for a module matching what is already imported
          var matchingPath = matchingImportStatement.path;

          return jsModules.find(function (jsModule) {
            return matchingPath === jsModule.toImportStatement(_this10.config).path;
          });
        }

        // We couldn't resolve any module for the variable. As a fallback, we
        // can use the matching import statement. If that maps to a package
        // dependency, we will still open the right file.
        var hasNamedExports = matchingImportStatement.defaultImport !== variableName;

        var matchedModule = new _JsModule2['default']({
          importPath: matchingImportStatement.path,
          hasNamedExports,
          variableName
        });

        return matchedModule;
      }

      return resolveModuleUsingCurrentImports;
    }()
  }, {
    key: 'injectSideEffectImports',
    value: function () {
      function injectSideEffectImports(importStatements) {
        var _this11 = this;

        var addedImports = [];
        this.config.get('moduleSideEffectImports').forEach(function (path) {
          var sizeBefore = importStatements.size();
          importStatements.push(new _ImportStatement2['default']({
            namedImports: [],
            defaultImport: '',
            hasSideEffects: true,
            declarationKeyword: _this11.config.get('declarationKeyword'),
            importFunction: _this11.config.get('importFunction'),
            path
          }));
          if (importStatements.size() > sizeBefore) {
            // The number of imports changed as part of adding the side-effect
            // import. This means that the import wasn't previously there.
            addedImports.push('\'' + String(path) + '\'');
          }
        });
        return addedImports;
      }

      return injectSideEffectImports;
    }()
  }]);

  return Importer;
}();

exports['default'] = Importer;
module.exports = exports['default'];