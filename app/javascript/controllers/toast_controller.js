import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { timeout: Number }

  connect() {
    console.log("[Stimulus] ToastController connected", this.element)
    this.timeout = setTimeout(() => {
      console.log("[Stimulus] ToastController fading out toast")
      this.element.classList.add("opacity-0", "pointer-events-none")
      setTimeout(() => {
        console.log("[Stimulus] ToastController removing toast")
        this.element.remove()
      }, 500)
    }, this.timeoutValue || 2000)
  }

  disconnect() {
    clearTimeout(this.timeout)
  }
}