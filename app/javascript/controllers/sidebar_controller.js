import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  static targets = [
    "sidebarContainer",
    "sidebarUl",
    "sidebarUlHelp",
  ];

  connect() {
    console.log(this.sidebarUlTarget)
    if (document.cookie.includes("sidebar_expanded=false")) {
      this.sidebarUlTarget.classList.toggle("items-center");
      this.sidebarUlHelpTarget.classList.toggle("flex-col");
      this.sidebarUlHelpTarget.classList.toggle("items-center");
    }

    // Attach open button functionality if the button exists
    this.openButton = document.querySelector("#open-sidebar-mobile");
    if (this.openButton) {
      this.openButton.addEventListener("click", this.open.bind(this));
    }
  }

  disconnect() {
    // Remove event listener when the controller disconnects
    if (this.openButton) {
      this.openButton.removeEventListener("click", this.open.bind(this));
    }
  }

  toggle(e) {
    e.preventDefault();
    this.switchCurrentState();
  }

  close(e) {
    e.preventDefault();
    this.element.classList.add("-translate-x-full");
  }

  open(e) {
    e.preventDefault();
    this.element.classList.remove("-translate-x-full");
  }

  switchCurrentState() {
    const newState = this.element.dataset.expanded === "true" ? "false" : "true";
    this.element.dataset.expanded = newState;

    if (newState === "true") {
      this.sidebarUlTarget.classList.toggle("items-center");
      this.sidebarUlHelpTarget.classList.toggle("flex-col");
      this.sidebarUlHelpTarget.classList.toggle("items-center");
    } else {
      this.sidebarUlTarget.classList.toggle("items-center");
      this.sidebarUlHelpTarget.classList.toggle("flex-col");
      this.sidebarUlHelpTarget.classList.toggle("items-center");
    }
    document.cookie = `sidebar_expanded=${newState}`;
  }
}
