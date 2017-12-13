module.exports = {
    // aliases: {
    //     $: 'third-party-libs/jquery',
    //     _: 'third-party-libs/underscore',
    // },
    // ignorePackagePrefixes: ['my-company-'],
    // logLevel: 'debug',
    // mergableOptions: {
    //     aliases: true,
    //     coreModules: true,
    //     namedExports: true,
    //     globals: true,
    // }
    excludes: [ './tests/**', './build-assets/**', './e2e/node_modules/**', './mockData/*', '../mockData/*' ],
    importFunction: 'require',
    sortImports: false,
    groupImports: true,
    importDevDependencies: true,
    stripFileExtensions: ['.jsx', '.js'],
    maxLineLength: 120,
    tab: '    ',
    environments: ['browser', 'node', 'mocha', 'es2017'],
    useRelativePaths({ pathToImportedModule, pathToCurrentFile }) {
        if (pathToCurrentFile.includes('app')) {
            return false
        }

        return true
    },
    declarationKeyword({ pathToImportedModule, pathToCurrentFile }) {
        if (pathToCurrentFile.includes('app') || pathToCurrentFile.includes('e2e')) {
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
