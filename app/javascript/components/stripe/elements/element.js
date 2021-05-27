import { Controller } from "stimulus"
import merge from "lodash/merge"
import { useDispatch } from "stimulus-use"
import pollPaymentIntentStatus from "./poll_payment_intent_status"

class Element extends Controller {
  static targets = ["stripeElement"]
  static values = { style: Object }

  connect() {
    if (!this.elements) return

    const url = new URL(window.location.href)
    if (url.searchParams.get("payment_intent")) {
      if (
        url.searchParams.get("source") &&
        url.searchParams.get("client_secret")
      ) {
        mainElement.classList.add("checkout", "success", "processing")
      }
      // Poll the PaymentIntent status.
      pollPaymentIntentStatus(url.searchParams.get("payment_intent"))
    }
    document.getElementById("main").classList.remove("loading")

    useDispatch(this, { eventPrefix: "stripe:element" })
    this.element["elementController"] = this
    this.mount()
  }

  mount() {
    if (!this.hasStripeElementTarget) return
    this.stripeElement = this.elements.create(
      this.stripeElementType,
      this.stripeElementOptions
    )
    this.stripeElement.mount(this.stripeElementTarget)
    this.stripeElement.on("change", this.handleChange.bind(this))
  }

  handleChange(event) {
    this.dispatch("change", event)
  }

  handlePayment(event) {
    console.log("handlePayment", event)
    if (event.error) {
      this.dispatch("error", event)
    } else {
      this.dispatch("success", event)
    }
  }

  get stripeElementOptions() {
    return { style: this.style }
  }

  get billingAddress() {
    return this.elementsController.billingAddress
  }

  get style() {
    return merge(this.styleValue, this.baseStyle)
  }

  get baseStyle() {
    return this.elementsController.style
  }

  get clientSecret() {
    return this.elementsController.clientSecret
  }

  get elements() {
    if (!this.stripe) return
    return this.stripe.elements()
  }

  get stripe() {
    if (!this.elementsController) return
    return this.elementsController.stripe
  }

  get elementsController() {
    if (!this.stripeElementsElement) return
    return this.stripeElementsElement.elementsController
  }

  get stripeElementsElement() {
    return this.element.closest(".Stripe-Elements")
  }
}

export default Element
