import { Controller } from "stimulus"
import { useDispatch } from "stimulus-use"

export default class extends Controller {
  static targets = ["element", "button"]

  connect() {
    useDispatch(this, { eventPrefix: "stripe:elements" })
  }

  select(event) {
    const clickedButton = event.target
    this.buttonTargets.forEach((button) => {
      button.setAttribute("aria-selected", button === clickedButton)
    })
    this.elementTargets.forEach((element) => {
      element.hidden =
        element.dataset.identifier != clickedButton.dataset.element
    })
  }
}
