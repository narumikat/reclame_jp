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
      console.log(`Selected value: ${selectedValue}`)
      if (selectedValue === "true") {
        this.companySelectTarget.style.display = "block"
        console.log("Company select displayed")
      } else {
        this.companySelectTarget.style.display = "none"
        console.log("Company select hidden")
      }
    } else {
      console.log("No radio button selected")
      this.companySelectTarget.style.display = "none"
    }
  }
}
