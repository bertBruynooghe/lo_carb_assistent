/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import { Application } from '@hotwired/stimulus'
import { definitionsFromContext } from '@hotwired/stimulus-webpack-helpers'
// import initServiceWorker from '../src/service_worker_companion'

window.Stimulus = Application.start()
const context = require.context('../src/controllers', true, /\.js$/)
Stimulus.load(definitionsFromContext(context))

// initServiceWorker()
// console.log('Hello World from Webpacker!')
