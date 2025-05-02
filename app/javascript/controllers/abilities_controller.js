import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["select"];

  connect() {
    this.updateOptions();
  }

  updateOptions() {
    const selectedValues = Array.from(this.element.querySelectorAll("select"))
      .map(select => select.value)
      .filter(value => value);

    this.element.querySelectorAll("select").forEach(select => {
      const currentValue = select.value;
      const options = select.querySelectorAll("option");

      options.forEach(option => {
        option.disabled = selectedValues.includes(option.value) && option.value !== currentValue;
      });
    });
  }

  updateDisplayer(event) {
    /*const displayer = this.element.querySelector(".displayer");
    const selectedValues = Array.from(this.element.querySelectorAll("select"))
      .map(select => select.value)
      .filter(value => value);

    displayer.innerHTML = selectedValues.join(", ");*/

    console.log(event.target.dataset.abilityName)
    console.log(event.target.value)
  }
}