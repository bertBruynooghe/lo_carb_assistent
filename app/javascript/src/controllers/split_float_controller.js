import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ 'integral', 'fractional' ]

  connect() {
    // console.log('connected', this.integralTarget)
    this.integralTarget.addEventListener('keypress', e => {
      const keyCode = (typeof e.which == 'number') ? e.which : e.keyCode
      if (window.decimalSeparator.charCodeAt(0) !== keyCode) return
      e.preventDefault()
      this.fractionalTarget.focus()
      }
    )
  }
}
