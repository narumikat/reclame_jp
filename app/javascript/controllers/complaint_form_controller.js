import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="controller"
export default class extends Controller {
  static targets = [ "newComplaintBtn", "formComplaint" ]
  connect() {
  }

  toggleForm(event) {
    event.preventDefault()
    this.formComplaintTarget.classList.toggle("visible")
    if(this.formComplaintTarget.classList.contains("visible")) {
      this.newComplaintBtnTarget.innerHTML = "Fechar"
    } else {
      this.newComplaintBtnTarget.innerHTML = "Reclamar"
    }
  }
}
