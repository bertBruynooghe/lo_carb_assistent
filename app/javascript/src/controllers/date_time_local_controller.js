import { Controller } from '@hotwired/stimulus'
import I18n from '../i18n.js.erb'

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
    var text = date.getHours() + ':' + ((100 + date.getMinutes())+'').slice(1)
    if (!inLast24Hours(date)){ text += (' ' + I18n.t('date.abbr_day_names')[date.getDay()]) }
    if (!inLastWeek(date)) { text += (', ' + date.getDate() + '/' + (date.getMonth()+1)) }
    if (!inLastYear(date)) { text += ('/' + date.getFullYear() ) }
    this.element.innerHTML = text
  }
}
