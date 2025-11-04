import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="char-visualizer"
export default class extends Controller {
  static targets = [
    "classDisplay",
    "nameDisplay",
    "imageDisplay",
    "raceDisplay",
    "levelDisplay",
    "tokenInput",
    "tokenForm",
    "strengthDisplay",
    "dexterityDisplay",
    "constitutionDisplay",
    "intelligenceDisplay",
    "wisdomDisplay",
    "charismaDisplay",
  ]

  connect() {
    if (this.hasImageDisplayTarget) {
      const currentImage = this.imageDisplayTarget.dataset.imageUrl
      if (currentImage) this.updateImage(currentImage)
    }
  }

  changeClass(event) {
    const klassName = event.target.value
    this.classDisplayTarget.textContent = klassName

    if (klassName) {
      const imageName = klassName.toLowerCase()
      this.updateImage(`/assets/${imageName}.png`)
    }
  }

  changeName(event) {
    this.nameDisplayTarget.textContent = event.target.value
  }

  changeRace(event) {
    this.raceDisplayTarget.textContent = event.target.value
  }

  submitToken(event) {
    const input = event.target
    const file = input.files[0]

    if (!file) return

    const reader = new FileReader()
    reader.onload = (e) => {
      this.updateImage(e.target.result)
    }
    reader.readAsDataURL(file)

    if (this.hasTokenFormTarget) {
      this.tokenFormTarget.requestSubmit()
    }
  }

  updateAbility(event) {
    const { ability, total } = event.detail
    if (!ability) return

    const display = this.targets.find(`${ability}Display`)
    if (display) {
      display.textContent = Number.isFinite(total) ? total : "--"
    }
  }

  updateImage(url) {
    if (!this.hasImageDisplayTarget || !url) return

    this.imageDisplayTarget.style.backgroundImage = `url(${url})`
    this.imageDisplayTarget.dataset.imageUrl = url
  }
}
