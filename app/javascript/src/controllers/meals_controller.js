import { Controller } from '@hotwired/stimulus'
import dbConnection from '../db_connection'

export default class extends Controller {
  static targets = ['tableBody']

  async connect() {
    const transaction = (await dbConnection).transaction('meals', 'readonly')
    const meals = transaction.objectStore('meals')
    const request = meals.count()
    request.onsuccess = () => console.log('meals', request.result)
    // if (indexedDb meals has rows) // otherwise the table is okay, since that means the database is never updated 
    //   delete all rows
    //   fill out rows of table based on indexedDb
    // send all meals that have been created/modified locally after last fetch time
    // receive all meals the have been created/modified remotely after last fetch time
    // update last fetch time
    // show alert if stuff has been changed

    // TODO: don't hardcode the meals apth
    const result = await fetch('/meals.json')
    const rows = (await result.json()).reverse()
    console.log('fetch', result.status, rows)
    rows.forEach(r => {
      const tr = document.createElement('tr')
      const td = document.createElement('td')
      tr.innerHTML = `<td>${JSON.stringify(r)}</td>`
      this.tableBodyTarget.prepend(tr)
    })
  }
}
