import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["links"];
  static values = { startIndex: Number, currentIndex: Number };

  connect() {
    // this.startIndex = this.startIndexValue || 0;
    // this.currentIndex = this.currentIndexValue || this.startIndexValue;
    this.selectedClass = this.data.get("selectedClass") || null;
    this.unselectedClass = this.data.get("unselectedClass") || null;

    this._applyStyleOnStart();
  }

  select(event) {
    event.preventDefault();

    this.currentIndexValue = event.target.dataset.index;
  }

  currentIndexValueChanged() {
    this.linksTargets.forEach((element, index) => {
      if (this.currentIndexValue === index) {
        element.setAttribute("aria-current", "page");
        this._selectedClassList[0].forEach((klass) =>
          element.classList.add(klass)
        );
        this._unselectedClassList[0].forEach((klass) =>
          element.classList.remove(klass)
        );
      } else {
        element.removeAttribute("aria-current");
        this._selectedClassList[0].forEach((klass) =>
          element.classList.remove(klass)
        );
        this._unselectedClassList[0].forEach((klass) =>
          element.classList.add(klass)
        );
      }
    });
  }

  _applyStyleOnStart() {
    this.linksTargets.forEach((element, index) => {
      if (this.startIndexValue === index) {
        element.setAttribute("aria-current", "page");

        this._selectedClassList[0].forEach((klass) =>
          element.classList.add(klass)
        );

        this._unselectedClassList[0].forEach((klass) =>
          element.classList.remove(klass)
        );
      }
    });
  }

  get _selectedClassList() {
    return !this.selectedClass
      ? [[], []]
      : this.selectedClass.split(",").map((classList) => classList.split(" "));
  }

  get _unselectedClassList() {
    return !this.unselectedClass
      ? [[], []]
      : this.unselectedClass
          .split(",")
          .map((classList) => classList.split(" "));
  }
}
