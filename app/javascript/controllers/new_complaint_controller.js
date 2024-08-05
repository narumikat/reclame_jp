import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["complaintCompanySelect"]

  connect() {
    document.addEventListener('DOMContentLoaded', () => {
      this.showFormComplaint();
    });
    console.log("Complaint controller connected");
  }

  showFormComplaint() {
    if (this.complaintCompanySelectTarget.classList.contains('d-none')) {
      this.complaintCompanySelectTarget.classList.remove('d-none');
    } else {
      this.complaintCompanySelectTarget.classList.add('d-none');
    }
  }
}
