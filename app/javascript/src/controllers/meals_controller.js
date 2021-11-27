import { Controller } from '@hotwired/stimulus'
import ejs from 'ejs'

import dbConnection from '../db_connection'
import rowPartial from '_meals_row.html.erb'
import i18n from 'i18njs'
import { nl } from 'nl.yml'
// TODO: it's probably better to use I18n.backend.translations[:nl].to_json

i18n.add('nl', nl)
i18n.setLang('nl');

const t = id => i18n.get(id)
const button_to = label => `<input type="submit" value="${label}">`

export default class extends Controller {
  static targets = ['tableBody']

  async connect() {
    const transaction = (await dbConnection).transaction('meals', 'readonly')
    const meals = transaction.objectStore('meals')
    const request = meals.count()
    request.onsuccess = () => console.log('meals', request.result)

    // TODO: don't hardcode the meals path
    const result = await fetch('/meals.json')
    const rows = (await result.json()).reverse()
    // TODO: remove the network response warning
    console.log('fetch', result.status, rows)
    rows.forEach(meal => {
      const temp = document.createElement('template')
      temp.innerHTML = ejs.render(rowPartial, { meal, t, button_to }, { escape: s => s }).trim()
      this.tableBodyTarget.prepend(temp.content.firstChild)
    })
  }
}
