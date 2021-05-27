import { Controller } from "stimulus"
import { useDispatch } from "stimulus-use"

export default class extends Controller {
  static targets = ["cardElement", "element", "errors"]
  static values = {
    billingAddress: Object,
    customerEmail: String,
    stripe: Object,
  }

  connect() {
    useDispatch(this, { eventPrefix: "stripe:elements" })
    this.stripe = Stripe(this.stripeValue.publishable_key)
    this.element["elementsController"] = this
  }

  confirmPayment() {
    if (!this.currentElementController) return
    this.currentElementController.confirmPayment()
  }

  handleError(event) {
    this.errorMessage = event.detail.error.message
    this.dispatch("error", event)
  }

  handleSuccess(event) {
    this.dispatch("success", event)
  }

  handleChange(event) {
    if (event.detail.error) {
      this.errorMessage = event.detail.error.message
    } else {
      this.errorMessage = ""
    }
  }

  set errorMessage(error) {
    this.errorsTarget.textContent = error
  }

  get clientSecret() {
    return this.stripeValue.client_secret
  }

  get billingAddress() {
    const address = this.billingAddressValue
    return {
      line1: address.line1,
      line2: address.line2,
      postalCode: address.postalCode,
      city: address.city,
      state: address.state,
      country: address.country.data.alpha2,
    }
  }

  get currentElementController() {
    if (!this.currentElement) return
    return this.currentElement.elementController
  }

  get currentElement() {
    if (!this.hasElementTarget) return
    return this.elementTargets.find((element) => !element.hidden)
  }

  get style() {
    const bodyStyles = getComputedStyle(document.body)
    return {
      base: {
        color: bodyStyles.getPropertyValue("--main-color"),
        iconColor: bodyStyles.getPropertyValue("--main-color"),
        borderColor: bodyStyles.getPropertyValue("--main-color"),
      },
    }
  }
}
