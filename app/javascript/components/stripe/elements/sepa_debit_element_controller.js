import Element from "./element"
import merge from "lodash/merge"

export default class extends Element {
  static values = { placeholderCountry: String }

  confirmPayment() {
    // TODO
  }

  get stripeElementType() {
    return "iban"
  }

  get stripeElementOptions() {
    return merge(super.stripeElementOptions, {
      supportedCountries: ["SEPA"],
      placeholderCountry: this.placeholderCountryValue
    })
  }
}
