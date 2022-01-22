import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["emptyMessage"];

  connect() {
    this.element.dispatchEvent(
      new CustomEvent("addListItem", {
        bubbles: true,
        detail: {},
      })
    );
  }
}
