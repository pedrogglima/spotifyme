import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["field", "output"];
  static values = { counterChar: Number, default: 0 };
  static classes = ["overLimit", "underLimit"];

  connect() {
    let length = this.fieldTarget.value.length;
    this.outputTarget.textContent = `${length} characters`;
  }

  change() {
    let length = this.fieldTarget.value.length;
    this.outputTarget.textContent = `${length} characters`;

    if (length >= this.counterCharValue) {
      this.outputTarget.classList.remove(this.underLimitClass);
      this.outputTarget.classList.add(this.overLimitClass);
    } else {
      this.outputTarget.classList.add(this.underLimitClass);
      this.outputTarget.classList.remove(this.overLimitClass);
    }
  }

  limit() {
    let length = this.fieldTarget.value.length;

    if (length >= this.counterCharValue) {
      // need (-1) otherwise it permits one above the limit
      this.fieldTarget.value = this.fieldTarget.value.substr(
        0,
        this.counterCharValue - 1
      );
    }
  }
}
