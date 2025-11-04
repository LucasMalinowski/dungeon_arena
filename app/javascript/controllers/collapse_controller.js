import ToggleableController from "./shared/toggleable";

export default class extends ToggleableController {
  static targets = ["panel", "icon"];

  toggle(event) {
    event.preventDefault();
    const panel = this.hasPanelTarget ? this.panelTarget : document.getElementById(event.currentTarget.dataset.collapseTarget);

    if (!panel) return;

    panel.classList.toggle("hidden");

    if (this.hasIconTarget) {
      this.iconTarget.classList.toggle("rotate-180");
    }
  }
}
