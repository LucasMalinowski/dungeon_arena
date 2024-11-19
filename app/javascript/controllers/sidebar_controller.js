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
  }
  toggle(e) {
    e.preventDefault();
    this.switchCurrentState();
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
    // }
    document.cookie = `sidebar_expanded=${newState}`;
  }
}
