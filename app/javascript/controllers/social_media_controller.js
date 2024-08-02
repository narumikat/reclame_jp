// // app/javascript/controllers/social_media_controller.js
// import { Controller } from "@hotwired/stimulus"
//
// export default class extends Controller {
//     static targets = ["container", "addButton"]
//
//     connect() {
//         this.container = document.getElementById("social-media-links");
//         this.addButton = document.getElementById("add-social-media");
//
//         this.addButton.addEventListener("click", () => {
//             this.addSocialMediaGroup();
//         });
//
//         this.container.addEventListener("click", (event) => {
//             if (event.target.classList.contains("remove-social-media")) {
//                 event.target.parentElement.remove();
//             }
//         });
//     }
//
//     addSocialMediaGroup() {
//         var newSocialMediaGroup = document.querySelector(".social-media-group").cloneNode(true);
//         newSocialMediaGroup.querySelectorAll("input").forEach(function (input) {
//             input.value = "";
//         });
//         this.container.appendChild(newSocialMediaGroup);
//     }
// }
