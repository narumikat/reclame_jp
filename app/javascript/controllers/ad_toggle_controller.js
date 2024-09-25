import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    adId: Number,
    active: Boolean
  }

  toggle() {
    const newActiveStatus = !this.activeValue

    fetch(`/ads/${this.adIdValue}/toggle_active`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ active: newActiveStatus })
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        this.activeValue = newActiveStatus
        this.updateButton()
      } else {
        alert('Erro ao atualizar o status')
      }
    })
    .catch(error => {
      console.error('Erro:', error)
    })
  }

  updateButton() {
    this.element.textContent = this.activeValue ? 'Ativo' : 'Inativo'
    this.element.classList.toggle('green-tag', this.activeValue)
    this.element.classList.toggle('red-tag', !this.activeValue)
  }
}
