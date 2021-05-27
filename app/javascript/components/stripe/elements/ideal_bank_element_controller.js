import Element from "./element"

export default class extends Element {
  static targets = ["accountHolder"]

  async confirmPayment() {
    if (!this.stripe) return
    this.stripe
      .confirmIdealPayment(this.clientSecret, {
        payment_method: {
          ideal: this.stripeElement,
          billing_details: {
            name: this.accountHolderTarget.value
          }
        },
        return_url: window.location.href
      })
      .then(response => this.handlePayment(response))
  }

  get stripeElementType() {
    return "idealBank"
  }
}
