import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="char-visualizer"
export default class extends Controller {
  static targets = ["classDisplay", "nameDisplay", "imageDisplay", "raceDisplay"];

  connect() {
  }

  changeClass(event) {
    this.classDisplayTarget.textContent = event.target.value

    const imageName = event.target.value.toLowerCase(); // The value of the input (e.g., "image_name.jpg")
    const assetPath = `/assets/${imageName}.png`; // Adjust this if your assets are in a specific subfolder

    // Set the background image
    this.imageDisplayTarget.style.backgroundImage = `url(${assetPath})`;
  }

  changeName(event) {
    this.nameDisplayTarget.textContent = event.target.value
  }

  changeRace(event) {
    this.raceDisplayTarget.textContent = event.target.value
  }

  submit(event) {
    const input = event.target;
    const form = input.closest("form");

    if (input.files.length > 0) {
      const file = input.files[0];
      const reader = new FileReader();

      reader.onload = (e) => {
        // Atualiza a imagem de fundo com a pré-visualização
        this.imageDisplayTarget.style.backgroundImage = `url(${e.target.result})`;
      };

      reader.readAsDataURL(file);

      // Envia o formulário automaticamente
      form.requestSubmit();
    }
  }
}
