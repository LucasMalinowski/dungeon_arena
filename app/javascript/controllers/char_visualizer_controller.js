import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["classDisplay", "nameDisplay", "imageDisplay", "raceDisplay", "tokenInput"];

  connect() {
    if (this.hasClassDisplayTarget) {
      this.#updateBackgroundFrom(this.classDisplayTarget.textContent);
    }
  }

  updateClass(event) {
    const value = event.target.value;

    if (this.hasClassDisplayTarget) {
      this.classDisplayTarget.textContent = value;
    }

    this.#updateBackgroundFrom(value);
  }

  updateName(event) {
    if (this.hasNameDisplayTarget) {
      const text = event.target.value?.trim();
      this.nameDisplayTarget.textContent = text || "Unnamed Hero";
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

    const sanitized = value.trim();
    if (!sanitized || sanitized.startsWith("-")) return;

    const assetName = sanitized
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, "_");

    const url = `/assets/${assetName}.png`;
    this.imageDisplayTarget.style.backgroundImage = `linear-gradient(180deg, rgba(15,23,42,0.65) 0%, rgba(12,10,9,0.9) 100%), url('${url}')`;
    this.imageDisplayTarget.classList.add("bg-cover", "bg-center", "bg-no-repeat");
  }

  #previewFile(file) {
    if (!this.hasImageDisplayTarget) return;

    const reader = new FileReader();
    reader.onload = (event) => {
      const result = event.target?.result;
      if (!result) return;

      this.imageDisplayTarget.style.backgroundImage = `linear-gradient(180deg, rgba(15,23,42,0.65) 0%, rgba(12,10,9,0.9) 100%), url('${result}')`;
      this.imageDisplayTarget.classList.add("bg-cover", "bg-center", "bg-no-repeat");
    };

    reader.readAsDataURL(file);
  }
}
