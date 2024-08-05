import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["companySelect"]

  connect() {
    this.toggleCompanySelect()
    console.log("Company controller connected")
  }

  toggleCompanySelect() {
    const selectedRadio = this.element.querySelector('input[name="registration_type[is_company]"]:checked')
    if (selectedRadio) {
      const selectedValue = selectedRadio.value
      if (selectedValue === "true") {
        this.companySelectTarget.style.display = "block"
      } else {
        this.companySelectTarget.style.display = "none"
      }
    } else {
      this.companySelectTarget.style.display = "none"
    }
  }
}
