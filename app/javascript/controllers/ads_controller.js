import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String, interval: Number }

  connect() {
    this.loadAds() 
    this.startRefreshing() 
  }

  disconnect() {
    this.stopRefreshing() 
  }

  startRefreshing() {
    this.interval = setInterval(() => {
      this.loadAds()
    }, this.intervalValue || 5000)
  }

  stopRefreshing() {
    clearInterval(this.interval)
  }

  loadAds() {
    fetch(this.urlValue)
      .then(response => response.text())
      .then(html => {
        this.element.innerHTML = html
      })
      .catch(error => {
        console.error("Erro ao carregar anúncios:", error)
      })
  }
}