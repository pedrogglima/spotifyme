import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["links", "contents"];
  static values = { startIndex: Number, currentIndex: Number };

  connect() {
    this.selectedClass = this.data.get("selectedClass") || null;
    this.unselectedClass = this.data.get("unselectedClass") || null;
    this.invisibleClass = this.data.get("invisibleClass") || "hidden";

    this._applyStyleOnStart();
  }

  select(event) {
    if (event.target.dataset.downloaded == "true") {
      event.preventDefault();
    }

    event.target.dataset.downloaded = "true";
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

    this.contentsTargets.forEach((element, index) => {
      if (this.currentIndexValue === index) {
        element.classList.remove(this.invisibleClass);
      } else {
        element.classList.add(this.invisibleClass);
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

    this.contentsTargets.forEach((element, index) => {
      if (this.startIndexValue === index) {
        element.classList.remove(this.invisibleClass);
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
