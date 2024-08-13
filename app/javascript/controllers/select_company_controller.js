import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["companySelect", "companySelectBtn", "companyRadio"]

  connect() {
  }
  
  toggleCompanySelect(event) {
    event.preventDefault()
    
    this.companySelectTarget.classList.toggle("visible")
    if(this.companySelectTarget.classList.contains("visible")) {
      this.companySelectBtnTarget.innerHTML = "Fechar"
    } else {
      this.companySelectBtnTarget.innerHTML = "Acessar área da empresa"
    }
    this.companyRadioTarget.checked = true; // Marca o botão de rádio como true
    this.element.closest('form').submit();
  }
}
