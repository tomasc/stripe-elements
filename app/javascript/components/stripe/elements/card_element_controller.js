import { Controller } from "stimulus"
import merge from "lodash/merge"

export default class extends Controller {
  static targets = ["cardHolder", "stripeElement"]

  confirmPayment() {
    if (!this.stripe) return
    this.stripe
      .confirmCardPayment(this.clientSecret, {
        payment_method: {
          card: this.stripeElement,
          billing_details: {
            name: this.cardHolderTarget.value,
            address: this.billingAddress,
          },
        },
      })
      .then((response) => this.handlePayment(response))
  }

  get stripeElementType() {
    return "card"
  }

  get stripeElementOptions() {
    return merge(super.stripeElementOptions, { hidePostalCode: true })
  }
}
