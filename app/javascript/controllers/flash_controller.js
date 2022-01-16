import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.dismiss();
    }, 3900);
  }

  dismiss() {
    this.element.remove();
  }

  disconnect() {
    this.dismiss();
  }
}
