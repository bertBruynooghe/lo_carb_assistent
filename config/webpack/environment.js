const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')

// TODO: this doesn't work to render htmls from views, 
// since the views contain references to webpack compiled files,
// which are not available at webpack build time.

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
        name: '[contenthash].html'
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
