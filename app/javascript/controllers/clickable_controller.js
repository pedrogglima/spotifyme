import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["component"];

  connect() {
    this.invisibleClass = this.data.get("invisibleClass") || "hidden";
  }

  hide(event) {
    this.componentTarget.classList.add(this.invisibleClass);
  }
}
