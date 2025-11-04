import ToggleableController from "./shared/toggleable";

export default class extends ToggleableController {
  static targets = ["modal"]; // maintain compatibility if needed

  close() {
    this.element.remove();
  }
}
