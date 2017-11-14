const path = require('path')

module.exports = {
    excludes: [
        'tests/*',
        '.git/*',
        'build-assets/*'
    ],
    aliases: {
        actions: path.resolve(__dirname, 'app/js/actions/'),
        components: path.resolve(__dirname, 'app/js/components/'),
        constants: path.resolve(__dirname, 'app/js/constants/'),
        containers: path.resolve(__dirname, 'app/js/containers/'),
        higherOrderComponents: path.resolve(__dirname, 'app/js/higherOrderComponents/'),
        reducers: path.resolve(__dirname, 'app/js/reducers/'),
        saga: path.resolve(__dirname, 'app/js/saga/'),
        store: path.resolve(__dirname, 'app/js/store/'),
        utils: path.resolve(__dirname, 'app/js/utils/')
    },
    environments: ['browser', 'node'],
    declarationKeyword: 'import',
    sortImports: false,
    importDevDependencies: true,
    useRelativePaths: true,
    maxLineLength: 120,
    importStatementFormatter({ importStatement }) {
        return importStatement.replace(/;$/, '').replace(/(\.+\/)/g, '');
    },
    tab: '\t'
}
