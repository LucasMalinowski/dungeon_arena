import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebarUl", "sidebarUlHelp"]

  connect() {
    if (document.cookie.includes("sidebar_expanded=false")) {
      this.sidebarUlTarget.classList.toggle("items-center")
      this.sidebarUlHelpTarget.classList.toggle("flex-col")
      this.sidebarUlHelpTarget.classList.toggle("items-center")
    }

    this.openButton = document.querySelector("#open-sidebar-mobile")
    if (this.openButton) {
      this.openHandler = this.open.bind(this)
      this.openButton.addEventListener("click", this.openHandler)
    }
  }

  disconnect() {
    if (this.openButton && this.openHandler) {
      this.openButton.removeEventListener("click", this.openHandler)
    }
  }

  toggle(e) {
    e.preventDefault()
    this.switchCurrentState()
  }

  close(e) {
    e.preventDefault()
    this.element.classList.add("-translate-x-full")
  }

  open(e) {
    e.preventDefault()
    this.element.classList.remove("-translate-x-full")
  }

  switchCurrentState() {
    const newState = this.element.dataset.expanded === "true" ? "false" : "true"
    this.element.dataset.expanded = newState

    this.sidebarUlTarget.classList.toggle("items-center")
    this.sidebarUlHelpTarget.classList.toggle("flex-col")
    this.sidebarUlHelpTarget.classList.toggle("items-center")

    document.cookie = `sidebar_expanded=${newState}`
  }
}
