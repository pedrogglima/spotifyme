import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["links"];
  static classes = ["path"];

  connect() {
    this.selectedClass = this.data.get("selectedClass") || null;
    this.unselectedClass = this.data.get("unselectedClass") || null;
    const pathname = window.location.pathname.replace(/\//g, "");

    if (this.pathClasses.includes(pathname)) {
      this._applyStyle(pathname);
    }
  }

  _applyStyle(pathname) {
    this.linksTargets.forEach((element, index) => {
      if (element.dataset.path === pathname) {
        element.setAttribute("aria-current", "page");

        this._unselectedClassList[0].forEach((klass) =>
          element.classList.remove(klass)
        );

        this._selectedClassList[0].forEach((klass) =>
          element.classList.add(klass)
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

  get _pathesClassList() {
    return !this.pathClasses
      ? [[], []]
      : this.pathClasses.split(",").map((classList) => classList.split(" "));
  }
}
