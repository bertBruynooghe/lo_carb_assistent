const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')

const htmlErbLoader = {
  test: /\.html\.erb$/,
  enforce: 'pre',
  exclude: /node_modules/,
  use: [
    { 
      loader: 'file-loader',
      options: {
        esModule:false,
        context: 'app/javascript',
        name: '[name][contenthash].html'
      }
    },
    {
      loader: 'rails-erb-loader',
      options: {
        runner: (/^win/.test(process.platform) ? 'ruby ' : '') + 'bin/rails runner'
      }
    }
  ]
}

const webmanifestErbLoader = {
  test: /app\.webmanifest\.erb$/,
  enforce: 'pre',
  exclude: /node_modules/,
  use: [
    { 
      loader: 'file-loader',
      options: {
        esModule:false,
        context: 'app/javascript',
        name: 'app-[contenthash].webmanifest'
      }
    },
    {
      loader: 'rails-erb-loader',
      options: {
        runner: (/^win/.test(process.platform) ? 'ruby ' : '') + 'bin/rails runner'
      }
    }
  ]
}

environment.loaders.prepend('erb', erb)
environment.loaders.prepend('htmlErb', htmlErbLoader )
environment.loaders.prepend('manifestErb', webmanifestErbLoader)

module.exports = environment
