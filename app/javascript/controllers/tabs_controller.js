import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["tab", "content"];

  switch(event) {
    const tabName = event.target.dataset.tabName;

    // Update tab button styles
    this.tabTargets.forEach((tab) => {
      const isActive = tab.dataset.tabName === tabName;

      tab.classList.toggle("border-green-500", isActive); // Active border
      tab.classList.toggle("text-green-500", isActive); // Active text
      tab.classList.toggle("border-gray-700", !isActive); // Inactive border
      tab.classList.toggle("text-white", !isActive); // Inactive text
    });

    // Show the correct content
    this.contentTargets.forEach((content) => {
      content.classList.toggle("hidden", content.dataset.tabName !== tabName);
    });
  }
}
