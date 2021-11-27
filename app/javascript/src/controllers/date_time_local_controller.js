import { Controller } from '@hotwired/stimulus'

function inLast24Hours(date) {
  const value = new Date().valueOf() - date.valueOf()
  return 0 < value && value < (24 * 60 * 60 * 1000)
}

function inLastYear(date) {
  const value = new Date().valueOf() - date.valueOf()
  return 0 < value && value < (365 * 24 * 60 * 60 * 1000)
}

function inLastWeek(date) {
  const value = new Date().valueOf() - date.valueOf()
  return 0 < value && value < (7 * 24 * 60 * 60 * 1000)
}

export default class extends Controller {
  connect() {
    const date = new Date(this.element.innerHTML.trim())
    const text = date.getHours() + ':' + ((100 + date.getMinutes())+'').slice(1)
    if (!inLast24Hours(date)){ text += (' ' + window.abbrDayNames[date.getDay()]) }
    if (!inLastWeek(date)) { text += (', ' + date.getDate() + '/' + (date.getMonth()+1)) }
    if (!inLastYear(date)) { text += ('/' + date.getFullYear() ) }
    this.element.innerHTML = text
  }
}