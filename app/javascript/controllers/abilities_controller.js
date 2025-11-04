import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select", "display"]

  connect() {
    this.updateOptions()
    this.refreshDisplays()
  }

  handleChange(event) {
    this.updateOptions()
    this.updateDisplay(event.target)
  }

  updateOptions() {
    const selectedValues = this.selectTargets
      .map((select) => select.value)
      .filter((value) => value)

    this.selectTargets.forEach((select) => {
      const currentValue = select.value

      Array.from(select.options).forEach((option) => {
        if (!option.value) return
        option.disabled = selectedValues.includes(option.value) && option.value !== currentValue
      })
    })
  }

  refreshDisplays() {
    this.selectTargets.forEach((select) => this.updateDisplay(select))
  }

  updateDisplay(select) {
    const ability = select.dataset.abilityName
    if (!ability) return

    const display = this.displayTargets.find((element) => element.dataset.ability === ability)
    if (!display) return

    const base = parseInt(select.value, 10)
    const bonus = parseInt(display.dataset.bonus || 0, 10)
    const total = Number.isFinite(base) ? base + bonus : null
    const modifier = Number.isFinite(total) ? Math.floor((total - 10) / 2) : null

    this.updateMetric(display, "base", Number.isFinite(base) ? base : "--")
    this.updateMetric(display, "total", Number.isFinite(total) ? total : "--")
    this.updateMetric(display, "modifier", Number.isFinite(modifier) ? this.formatModifier(modifier) : "--")

    this.dispatch("updated", { detail: { ability, total } })
  }

  updateMetric(container, role, value) {
    const element = container.querySelector(`[data-role="${role}"]`)
    if (element) {
      element.textContent = value
    }
  }

  formatModifier(value) {
    if (!Number.isFinite(value)) return value
    return value >= 0 ? `+${value}` : value
  }
}
