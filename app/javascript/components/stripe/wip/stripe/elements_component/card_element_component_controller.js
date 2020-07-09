import ElementComponent from "./element_component"

export default class extends ElementComponent {
  static targets = ["cardHolder", "card"]

  mount() {
    this.stripeElement = this.elements.create("card", {
      style: this.style,
      hidePostalCode: true
    })
    this.stripeElement.mount(this.cardTarget)
    this.stripeElement.on("change", this.onChange.bind(this))
  }

  confirmPayment() {
    const element = this.cardTarget
    this.stripe
      .confirmCardPayment(this.clientSecret, {
        payment_method: {
          card: this.stripeElement,
          billing_details: {
            name: this.cardHolderTarget.value,
            address: this.billingAddress
          }
        }
      })
      .then(result => {
        this.handlePayment(result)
      })
  }
}
