import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.timeout = setTimeout(() => {
      this.close();
    }, 2000);
  }

  close() {
    this.element.remove();
  }

  disconnect() {
    clearTimeout(this.timeout);
  }
}
