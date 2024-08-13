import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["companyNameInput", "companyIdInput", "suggestionsList"]

  autocomplete() {
    const query = this.companyNameInputTarget.value.trim();
    if (query.length < 2) {
      this.suggestionsListTarget.innerHTML = "";
      return;
    }

    const url = `/registration_type?query=${encodeURIComponent(query)}`;
    
    fetch(url, {
      headers: {
        'X-Requested-With': 'XMLHttpRequest'
      }
    })
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.json();
    })
    .then((data) => {
      this.showSuggestions(data);
    })
    .catch(error => {
      console.error('Error fetching autocomplete results:', error);
    });
  }

  showSuggestions(companies) {
    this.suggestionsListTarget.innerHTML = "";

    if (companies.length === 0) {
      const li = document.createElement("li");
      li.textContent = "Nenhum resultado";
      li.className = "list-group-item no-results";
      this.suggestionsListTarget.appendChild(li);
      return;
    }

    companies.forEach(company => {
      const li = document.createElement("li");
      li.textContent = company.name;
      li.dataset.id = company.id;
      li.className = "list-group-item";
      li.addEventListener("click", () => this.selectCompany(company));
      this.suggestionsListTarget.appendChild(li);
    });
  }

  selectCompany(company) {
    // Atualiza o campo do `collection_select` com o ID da empresa selecionada
    const collectionSelect = document.querySelector("select[name='registration_type[company_id]']");
    if (collectionSelect) {
      collectionSelect.value = company.id;
    }

    this.companyNameInputTarget.value = company.name;
    console.log("Company selected:", company.name, "ID:", company.id);  // Debug: Exibe o nome e o ID da empresa selecionada
    this.suggestionsListTarget.innerHTML = "";
  }
}
