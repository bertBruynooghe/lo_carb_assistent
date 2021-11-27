const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')

const yamlLoader = {
  test: /\.ya?ml$/,
  type: 'json', // Required by Webpack v4
  use: 'yaml-loader'
}

const htmlLoader = {
    test: /\.html(\.erb)?$/i,
    loader: 'html-loader',
}

environment.loaders.append('yaml', yamlLoader)
environment.loaders.append('html', htmlLoader)
environment.loaders.prepend('erb', erb)
module.exports = environment
