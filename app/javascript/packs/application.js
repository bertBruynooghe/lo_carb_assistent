/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//

import { Application } from '@hotwired/stimulus'
import { definitionsFromContext } from '@hotwired/stimulus-webpack-helpers'
import initServiceWorker from '../src/service_worker_companion'

const htmlTest = require('../../../public/404.html')
console.log({ htmlTest })

import { nl } from '../../../config/locales/nl.yml'
console.log({ nl })

window.Stimulus = Application.start()
const context = require.context('../src/controllers', true, /\.js$/)
Stimulus.load(definitionsFromContext(context))

initServiceWorker()
// console.log('Hello World from Webpacker!')
