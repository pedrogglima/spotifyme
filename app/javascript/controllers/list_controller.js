import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["emptyMessage"];

  connect() {
    this.invisibleClass = this.data.get("invisibleClass") || "hidden";
  }

  removeEmptyMessageOnList(event) {
    if (this.hasEmptyMessageTarget) {
      this.emptyMessageTarget.classList.add(this.invisibleClass);
    }
  }
}
