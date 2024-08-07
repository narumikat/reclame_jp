import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["complaintCompanySelect", "initialComplaintForm", "btnTargetToggle"]

  connect() {
    document.addEventListener('DOMContentLoaded', () => {
      this.showFormComplaint();
    });
    console.log("Complaint controller connected");
    console.log(this.initialComplaintFormTarget);
  }

  showFormComplaint() {
    setTimeout(() => {
      if (this.complaintCompanySelectTarget.classList.contains('d-none')) {
        this.initialComplaintFormTarget.classList.add('d-none');
        this.btnTargetToggleTarget.innerText = "Procurar empresa novamente";
        this.complaintCompanySelectTarget.classList.remove('d-none');
      } else {
        this.complaintCompanySelectTarget.classList.add('d-none');
        this.initialComplaintFormTarget.classList.remove('d-none');
        this.btnTargetToggleTarget.classList.remove('d-none');
        this.btnTargetToggleTarget.innerText = "Clique aqui se não encontrou a empresa";

      }
    }, 200);
  }
}