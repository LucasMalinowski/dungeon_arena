import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  toggle(event) {
    const targetId = event.target.dataset.collapseTarget;
    const target = document.getElementById(targetId);

    if (target) {
      target.classList.toggle("hidden");
    }
  }
}
