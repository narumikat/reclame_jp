import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["complaintCompanySelect", "initialComplaintForm", "btnTargetToggle"]

  showFormComplaint() {
    // Alterna a visibilidade dos formulários
    this.complaintCompanySelectTarget.classList.toggle('visible');
    this.initialComplaintFormTarget.classList.toggle('visible');

    // Ajusta o texto do botão de acordo com o formulário que está visível
    if (this.complaintCompanySelectTarget.classList.contains('visible')) {
      this.btnTargetToggleTarget.innerText = "Procurar empresa novamente";
    } else {
      this.btnTargetToggleTarget.innerText = "Clique aqui se não encontrou a empresa";
    }
  }
}
