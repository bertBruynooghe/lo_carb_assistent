const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')

const htmlLoader = {
    test: /\.html(\.erb)?$/i,
    loader: 'html-loader',
}

environment.loaders.append('html', htmlLoader)
environment.loaders.prepend('erb', erb)
module.exports = environment
