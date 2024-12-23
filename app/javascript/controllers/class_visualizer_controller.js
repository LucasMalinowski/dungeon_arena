import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="class-visualizer"
export default class extends Controller {
  static targets = ["classDisplay", "nameDisplay", "imageDisplay"];

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
}
