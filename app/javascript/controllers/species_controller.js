import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["radio"];

  connect() {
    this.selectedRadio = null; // Keeps track of the currently selected radio button
  }

  toggleRadio(event) {
    const clickedRadio = event.currentTarget;

    if (this.selectedRadio === clickedRadio) {
      // Uncheck if the same radio is clicked again
      clickedRadio.checked = false;
      this.selectedRadio = null;
    } else {
      // Uncheck all radios in the group
      this.radioTargets.forEach((radio) => (radio.checked = false));

      // Select the clicked radio
      clickedRadio.checked = true;
      this.selectedRadio = clickedRadio;
    }
  }
}
