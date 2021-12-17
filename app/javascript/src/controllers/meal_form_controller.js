import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['consumptionTime']

  connect() {
    if (!this.consumptionTimeTarget.value) {
      const [date, timePart] = new Date().toISOString().split('T')
      const [time] = timePart.split('.')
      this.consumptionTimeTarget.value = `${date} ${time} UTC`
    }
  }
}