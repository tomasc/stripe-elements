import ElementComponent from "./element_component"

export default class extends ElementComponent {
  static targets = ["sepaDebit"]

  mount() {
    if (!this.hasSepaDebitTarget) return
    this.stripeElement = this.elements.create("iban", {
      style: this.style,
      supportedCountries: ["SEPA"]
    })
    this.stripeElement.mount(this.cardTarget)
    this.stripeElement.on("change", this.onChange.bind(this))
  }

  confirmPayment() {
    // TODO
  }
}
