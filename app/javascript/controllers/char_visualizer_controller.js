import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["classDisplay", "nameDisplay", "imageDisplay", "raceDisplay", "tokenInput"];

  updateClass(event) {
    const value = event.target.value;
    if (this.hasClassDisplayTarget) {
      this.classDisplayTarget.textContent = value;
    }

    this.#updateBackgroundFrom(value);
  }

  updateName(event) {
    if (this.hasNameDisplayTarget) {
      this.nameDisplayTarget.textContent = event.target.value || "Unnamed Hero";
    }
  }

  updateRace(event) {
    if (this.hasRaceDisplayTarget) {
      this.raceDisplayTarget.textContent = event.target.value;
    }
  }

  uploadToken(event) {
    const input = event.target;
    if (!input.files || input.files.length === 0) return;

    const [file] = input.files;
    this.#previewFile(file);

    const form = input.closest("form");
    form?.requestSubmit();
  }

  #updateBackgroundFrom(value) {
    if (!this.hasImageDisplayTarget || !value) return;

    const fileName = value
      .toString()
      .trim()
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, "-");
    const assetPath = `/assets/${fileName}.png`;
    this.imageDisplayTarget.style.backgroundImage = `url(${assetPath})`;
  }

  #previewFile(file) {
    if (!this.hasImageDisplayTarget || !file) return;

    const reader = new FileReader();
    reader.onload = (event) => {
      this.imageDisplayTarget.style.backgroundImage = `url(${event.target.result})`;
    };
    reader.readAsDataURL(file);
  }
}
