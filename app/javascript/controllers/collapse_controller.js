import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "icon"]

  toggle(event) {
    event.preventDefault()

    this.panelTargets.forEach((panel) => {
      panel.classList.toggle("hidden")
    })

    this.iconTargets.forEach((icon) => {
      icon.classList.toggle("rotate-180")
    })
  }
}
