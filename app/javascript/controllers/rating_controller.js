
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["icon", "hiddenField"];

  connect() {
    console.log("Rating controller connected");
    this.updateIcons();
  }

  setRating(event) {
    const value = parseInt(event.currentTarget.dataset.value, 10);
    console.log(`Setting rating to: ${value}`);

    this.hiddenFieldTarget.value = value;
    this.updateIcons(value);
  }

  updateIcons(selectedValue = this.hiddenFieldTarget.value) {
    console.log(`Updating icons with selected value: ${selectedValue}`);

    this.iconTargets.forEach(icon => {
      const value = parseInt(icon.dataset.value, 10);
      if (value <= selectedValue) {
        icon.classList.add("selected");
      } else {
        icon.classList.remove("selected");
      }
    });
  }
}
