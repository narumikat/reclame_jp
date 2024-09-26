import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="photo-preview"
export default class extends Controller {
  connect() {
  }
static targets = ["previewContainer"];

  preview(event) {
    const previewContainer = document.getElementById("preview-container");
    previewContainer.innerHTML = ""; // Limpa as miniaturas existentes

    const files = event.target.files;
    const maxPhotos = this.element.dataset.maxPhotos; // Pega o valor do limite de fotos a partir do dataset

    if (files.length > maxPhotos) {
      alert(`Você pode enviar no máximo ${maxPhotos} fotos.`);
      event.target.value = ""; // Reseta o campo de seleção
      return;
    }

    Array.from(files).forEach(file => {
      const reader = new FileReader();
      reader.onload = (e) => {
        const img = document.createElement("img");
        img.src = e.target.result;
        img.alt = file.name;
        img.classList.add("img-thumbnail", "m-1");
        img.style.maxWidth = "150px";
        previewContainer.appendChild(img);
      };
      reader.readAsDataURL(file); // Lê o arquivo para base64
    });
  }
}