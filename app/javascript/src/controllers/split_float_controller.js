import { Controller } from '@hotwired/stimulus'
import I18n from '../i18n.js.erb'

export default class extends Controller {
  static targets = [ 'integral', 'fractional' ]

  connect() {
    // console.log('connected', this.integralTarget)
    this.integralTarget.addEventListener('keypress', e => {
      const keyCode = (typeof e.which == 'number') ? e.which : e.keyCode
      if (I18n.t('number.format.separator').charCodeAt(0) !== keyCode) return
      e.preventDefault()
      this.fractionalTarget.focus()
      }
    )
  }
}
