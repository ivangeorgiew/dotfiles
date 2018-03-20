Object.defineProperty(exports, "__esModule", {
  value: true
});

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _crypto = require('crypto');

var _crypto2 = _interopRequireDefault(_crypto);

var _os = require('os');

var _os2 = _interopRequireDefault(_os);

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

var _globals = require('globals');

var _globals2 = _interopRequireDefault(_globals);

var _semver = require('semver');

var _semver2 = _interopRequireDefault(_semver);

var _FileUtils = require('./FileUtils');

var _FileUtils2 = _interopRequireDefault(_FileUtils);

var _JsModule = require('./JsModule');

var _JsModule2 = _interopRequireDefault(_JsModule);

var _findPackageDependencies = require('./findPackageDependencies');

var _findPackageDependencies2 = _interopRequireDefault(_findPackageDependencies);

var _meteorEnvironment = require('./environments/meteorEnvironment');

var _meteorEnvironment2 = _interopRequireDefault(_meteorEnvironment);

var _nodeEnvironment = require('./environments/nodeEnvironment');

var _nodeEnvironment2 = _interopRequireDefault(_nodeEnvironment);

var _normalizePath = require('./normalizePath');

var _normalizePath2 = _interopRequireDefault(_normalizePath);

var _version = require('./version');

var _version2 = _interopRequireDefault(_version);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

var JSON_CONFIG_FILE = '.importjs.json';
var JS_CONFIG_FILE = '.importjs.js';

function findGlobalsFromEnvironments(environments) {
  var result = Object.keys(_globals2['default'].builtin);

  environments.forEach(function (environment) {
    var envGlobals = _globals2['default'][environment];
    if (!envGlobals) {
      return;
    }
    result.push.apply(result, _toConsumableArray(Object.keys(envGlobals)));
  });
  return result;
}

var DEFAULT_CONFIG = {
  aliases: {},
  declarationKeyword: 'import',
  cacheLocation: function () {
    function cacheLocation(_ref) {
      var config = _ref.config;

      var hash = _crypto2['default'].createHash('md5').update(String(config.workingDirectory) + '-v4').digest('hex');
      return _path2['default'].join(_os2['default'].tmpdir(), 'import-js-' + String(hash) + '.db');
    }

    return cacheLocation;
  }(),
  coreModules: [],
  namedExports: {},
  environments: [],
  excludes: [],
  globals: function () {
    function globals(_ref2) {
      var config = _ref2.config;
      return findGlobalsFromEnvironments(config.get('environments'));
    }

    return globals;
  }(),
  groupImports: true,
  ignorePackagePrefixes: [],
  importDevDependencies: false,
  importFunction: 'require',
  importStatementFormatter: function () {
    function importStatementFormatter(_ref3) {
      var importStatement = _ref3.importStatement;
      return importStatement;
    }

    return importStatementFormatter;
  }(),
  logLevel: 'info',
  maxLineLength: 80,
  minimumVersion: '0.0.0',
  moduleNameFormatter: function () {
    function moduleNameFormatter(_ref4) {
      var moduleName = _ref4.moduleName;
      return moduleName;
    }

    return moduleNameFormatter;
  }(),
  moduleSideEffectImports: function () {
    function moduleSideEffectImports() {
      return [];
    }

    return moduleSideEffectImports;
  }(),
  sortImports: true,
  stripFileExtensions: ['.js', '.jsx'],
  tab: '  ',
  useRelativePaths: true,
  packageDependencies: function () {
    function packageDependencies(_ref5) {
      var config = _ref5.config;
      return (0, _findPackageDependencies2['default'])(config.workingDirectory, config.get('importDevDependencies'));
    }

    return packageDependencies;
  }(),
  // Default configuration options, and options inherited from environment
  // configuration are overridden if they appear in user config. Some options,
  // however, get merged with the parent configuration. This list specifies which
  // ones are merged.
  mergableOptions: {
    aliases: true,
    coreModules: true,
    namedExports: true,
    globals: true
  }
};

var KNOWN_CONFIGURATION_OPTIONS = ['aliases', 'cacheLocation', 'coreModules', 'declarationKeyword', 'environments', 'excludes', 'globals', 'groupImports', 'ignorePackagePrefixes', 'importDevDependencies', 'importFunction', 'importStatementFormatter', 'logLevel', 'maxLineLength', 'minimumVersion', 'moduleNameFormatter', 'moduleSideEffectImports', 'namedExports', 'sortImports', 'stripFileExtensions', 'tab', 'useRelativePaths', 'mergableOptions'];

var DEPRECATED_CONFIGURATION_OPTIONS = ['namedExports'];

var ENVIRONMENTS = {
  node: _nodeEnvironment2['default'],
  meteor: _meteorEnvironment2['default']
};

function checkForUnknownConfiguration(config) {
  var messages = [];

  Object.keys(config).forEach(function (option) {
    if (KNOWN_CONFIGURATION_OPTIONS.indexOf(option) === -1) {
      messages.push('Unknown configuration: `' + String(option) + '`');
    }
  });

  return messages;
}

function checkForDeprecatedConfiguration(config) {
  var messages = [];

  Object.keys(config).forEach(function (option) {
    if (DEPRECATED_CONFIGURATION_OPTIONS.indexOf(option) !== -1) {
      messages.push('Using ' + String(option) + ' to configure ImportJS is deprecated and ' + 'will go away in a future version.');
    }
  });

  return messages;
}

/**
  * Checks that the current version is bigger than the `minimumVersion`
  * defined in config.
  * @throws Error if current version is less than the `minimumVersion` defined
  * in config.
  */
function checkCurrentVersion(minimumVersion) {
  if (_semver2['default'].gte((0, _version2['default'])(), minimumVersion)) {
    return;
  }

  throw Error('The configuration file for this project requires version ' + String(minimumVersion) + ' or newer. You are using ' + String((0, _version2['default'])()) + '.');
}

function mergedValue(values, key, options) {
  var mergedResult = void 0;
  for (var i = 0; i < values.length; i += 1) {
    var value = values[i];
    if (typeof value === 'function') {
      value = value(options);
    }
    // Prevent an endless loop of mergedValue calls
    // The mergableOptions key will get merged by skipping this check
    if (key !== 'mergableOptions') {
      var mergableOptions = options.config.get('mergableOptions');
      if (mergableOptions[key] !== true) {
        // This key shouldn't be merged
        return value;
      }
    }
    if (Array.isArray(value)) {
      mergedResult = (mergedResult || []).concat(value);
    } else if (typeof value === 'object') {
      mergedResult = Object.assign({}, value, mergedResult || {});
    } else {
      // Neither an object nor an array, so we just return the first value we
      // have.
      return value;
    }
  }
  return mergedResult;
}

// Class that initializes configuration from a .importjs.js file

var Configuration = function () {
  function Configuration(pathToCurrentFile) {
    var _this = this;

    var workingDirectory = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : process.cwd();

    _classCallCheck(this, Configuration);

    this.workingDirectory = workingDirectory;
    this.pathToCurrentFile = (0, _normalizePath2['default'])(pathToCurrentFile, workingDirectory);

    this.messages = [];
    this.configs = [];

    var userConfig = void 0;
    try {
      userConfig = this.loadUserConfig();
    } catch (error) {
      this.messages.push('Unable to parse configuration file. Reason:\n' + String(error.stack));
    }

    if (userConfig) {
      var _messages, _messages2;

      this.configs.push(userConfig);
      (_messages = this.messages).push.apply(_messages, _toConsumableArray(checkForUnknownConfiguration(userConfig)));
      (_messages2 = this.messages).push.apply(_messages2, _toConsumableArray(checkForDeprecatedConfiguration(userConfig)));

      // Add configurations for the environments specified in the user config
      // file.
      // Don't use `this.get` because the config hasn't finished initalizing.
      // Use userConfig instead since it's the only one declared
      if (typeof userConfig.environments === 'function') {
        userConfig.environments = userConfig.environments({
          config: this,
          pathToCurrentFile: this.pathToCurrentFile
        });
      }
      (userConfig.environments || []).forEach(function (environment) {
        var envConfig = ENVIRONMENTS[environment];
        if (envConfig) {
          _this.configs.push(envConfig);
        }
      });
    }

    this.configs.push(DEFAULT_CONFIG);

    checkCurrentVersion(this.get('minimumVersion'));
  }

  _createClass(Configuration, [{
    key: 'get',
    value: function () {
      function get(key) {
        var _ref6 = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {},
            pathToImportedModule = _ref6.pathToImportedModule,
            moduleName = _ref6.moduleName,
            importStatement = _ref6.importStatement;

        var applyingConfigs = this.configs.filter(function (config) {
          return Object.prototype.hasOwnProperty.call(config, key);
        });

        return mergedValue(applyingConfigs.map(function (config) {
          return config[key];
        }), key, {
          pathToImportedModule,
          moduleName,
          config: this,
          pathToCurrentFile: this.pathToCurrentFile,
          importStatement
        });
      }

      return get;
    }()
  }, {
    key: 'loadUserConfig',
    value: function () {
      function loadUserConfig() {
        var jsConfig = _FileUtils2['default'].readJsFile(_path2['default'].join(this.workingDirectory, JS_CONFIG_FILE));

        if (jsConfig && Object.keys(jsConfig).length === 0) {
          // If you forget to use `module.exports`, the config object will be `{}`.
          // To prevent subtle errors from happening, we surface an error message to
          // the user.
          throw new Error('Nothing exported from ' + JS_CONFIG_FILE + '. You need to use `module.exports` to specify what gets exported from the file.');
        }

        if (jsConfig) {
          return jsConfig;
        }

        var jsonConfig = _FileUtils2['default'].readJsonFile(_path2['default'].join(this.workingDirectory, JSON_CONFIG_FILE));

        if (jsonConfig) {
          this.messages.push('Using JSON to configure ImportJS is deprecated and will go away in a future version. Use an `.importjs.js` file instead.');
          return jsonConfig;
        }

        var globalConfig = _FileUtils2['default'].readJsFile(_path2['default'].join(_os2['default'].homedir(), JS_CONFIG_FILE));

        return globalConfig;
      }

      return loadUserConfig;
    }()
  }, {
    key: 'resolveAlias',
    value: function () {
      function resolveAlias(variableName) {
        var importPath = this.get('aliases')[variableName];
        if (!importPath) {
          return null;
        }

        importPath = importPath.path || importPath; // path may be an object

        if (this.pathToCurrentFile !== './') {
          // aliases can have dynamic `{filename}` parts
          importPath = importPath.replace(/\{filename\}/, _path2['default'].basename(this.pathToCurrentFile, _path2['default'].extname(this.pathToCurrentFile)));
        }
        return importPath;
      }

      return resolveAlias;
    }()
  }, {
    key: 'resolveNamedExports',
    value: function () {
      function resolveNamedExports(variableName) {
        var allNamedExports = this.get('namedExports');
        var importPath = Object.keys(allNamedExports).find(function (key) {
          return allNamedExports[key].indexOf(variableName) !== -1;
        });

        if (!importPath) {
          return undefined;
        }

        var jsModule = new _JsModule2['default']({
          importPath,
          hasNamedExports: true,
          variableName
        });
        return jsModule;
      }

      return resolveNamedExports;
    }()
  }]);

  return Configuration;
}();

exports['default'] = Configuration;
module.exports = exports['default'];