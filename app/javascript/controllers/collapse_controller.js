import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["target"];

  toggleTarget(event) {
    console.log("AAAAAAAA")
    console.log(event.currentTarget)
    console.log(this.targetTargets)
    const icon = event.currentTarget.querySelector(".fa-chevron-down");
    if (icon) {
      icon.classList.toggle("rotate-180");
    }
    this.targetTargets.forEach(target => {
      target.classList.toggle("hidden");
    });
  }
  toggle(event) {
    const targetId = event.target.dataset.collapseTarget;
    const target = document.getElementById(targetId);

    if (target) {
      target.classList.toggle("hidden");
    }
  }
}
