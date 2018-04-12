module.exports = {
    // aliases: {
    //     $: 'third-party-libs/jquery',
    //     _: 'third-party-libs/underscore',
    // },
    // ignorePackagePrefixes: ['my-company-'],
    // mergableOptions: {
    //     aliases: true,
    //     coreModules: true,
    //     namedExports: true,
    //     globals: true,
    // }
    // importFunction: 'require',
    // environments: ['browser', 'node'],
    logLevel: 'error',
    // excludes: [ './tests/**', './build-assets/**', './e2e/**', './mockData/**', '../mockData/**' ],
    excludes: [ '**/![app]/**' ],
    emptyLineBetweenGroups: false,
    sortImports: true,
    groupImports: true,
    importDevDependencies: true,
    danglingCommas: false,
    stripFileExtensions: ['.jsx', '.js'],
    maxLineLength: 120,
    tab: '    ',
    mergableOptions: { globals: false },
    globals: [],
    namedExports: {
        'prop-types': [ 'bool', 'number', 'string', 'object', 'array', 'func', 'element', 'any', 'oneOfType', 'oneOf', 'arrayOf', 'objectOf', 'shape' ],
        'immutable': [ 'fromJS', 'Map', 'List', 'OrderedMap', 'OrderedSet', 'Set', 'is', 'isImmutable' ]
    },
    useRelativePaths({ pathToImportedModule, pathToCurrentFile }) {
        if (pathToCurrentFile.includes('app')) {
            return false
        }

        return true
    },
    declarationKeyword({ pathToImportedModule, pathToCurrentFile }) {
        if (pathToCurrentFile.includes('app')) {
            return 'import'
        }

        return 'const'
    },
    moduleNameFormatter({ moduleName, pathToCurrentFile, pathToImportedModule }) {
        if (moduleName.startsWith('app/js/')) {
            return moduleName.replace('app/js/', '')
        }

        return moduleName
    },
    importStatementFormatter({ importStatement }) {
        return importStatement.replace(/;$/, '');
    }
}
