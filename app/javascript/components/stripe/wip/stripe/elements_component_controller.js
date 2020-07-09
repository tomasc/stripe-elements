import ApplicationController from "../../application_controller";

export default class extends ApplicationController {
  static targets = ["cardElement", "errors"];

  connect() {
    this.stripe = Stripe(this.data.get("stripePublishableKey"));
  }

  confirmPayment() {
    if (!this.currentElementController) return;
    this.currentElementController.confirmPayment();
  }

  onChange(event) {
    if (event.detail.error) {
      this.errorMessage = event.detail.error.message;
    } else {
      this.errorMessage = "";
    }
  }

  set errorMessage(error) {
    this.errorsTarget.textContent = error;
  }

  get clientSecret() {
    return this.data.get("stripeClientSecret");
  }

  get billingAddress() {
    const address = JSON.parse(this.data.get("billingAddress"));
    return {
      line1: address.line1,
      line2: address.line2,
      postalCode: address.postalCode,
      city: address.city,
      state: address.state,
      country: address.country.data.alpha2,
    };
  }

  get currentElementController() {
    return this.application.getControllerForElementAndIdentifier(
      this.cardElementTarget,
      "shop--stripe--elements-component--card-element-component"
    );
  }

  // I found a need for passing in some default styling via JS as I had css vars
  // which needed to be parsed via `getComputedStyle`
  get style() {
    return {};
  }
}
