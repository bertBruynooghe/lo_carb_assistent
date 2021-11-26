const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')

const yamlLoader = {
  test: /\.ya?ml$/,
  type: 'json', // Required by Webpack v4
  use: 'yaml-loader'
}

environment.loaders.prepend('erb', erb)
environment.loaders.append('yaml', yamlLoader)

module.exports = environment
