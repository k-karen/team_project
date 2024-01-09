import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Loaded form controller!")
  }
  reset() {
    this.element.reset()
  }
}
