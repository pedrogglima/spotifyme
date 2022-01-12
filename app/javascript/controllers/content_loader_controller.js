import { Controller } from "@hotwired/stimulus";
import { FetchRequest } from "@rails/request.js";

export default class extends Controller {
  static values = { url: String };

  async connect() {
    await this.load();
  }

  async load() {
    const request = new FetchRequest("get", this.urlValue, {
      responseKind: "html",
    });

    const response = await request.perform();

    if (response.ok) {
      this.element.innerHTML = await response.text;
    } else {
      // TODO: handle error
      console.log("error fetching");
    }
  }
}
