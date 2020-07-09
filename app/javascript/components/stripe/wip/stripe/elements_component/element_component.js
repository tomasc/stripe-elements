import ApplicationController from "../../../application_controller";
import merge from "lodash/merge";

class ElementComponent extends ApplicationController {
  connect() {
    if (!this.elements) return;
    this.mount();
  }

  onChange(originalEvent) {
    const event = new CustomEvent("stripe:element:change", {
      detail: originalEvent,
      bubbles: true,
    });
    this.element.dispatchEvent(event);
  }

  handlePayment(result) {
    if (result.error) {
      this.errorMessage = result.error.message;
      const event = new Event("stripe:error", { bubbles: true });
      this.element.dispatchEvent(event);
    } else {
      const event = new CustomEvent("stripe:success", {
        bubbles: true,
        detail: result.paymentIntent,
      });
      this.element.dispatchEvent(event);
    }
  }

  handleError(result) {
    this.errorMessage = result.error.message;
    const event = new Event("stripe:error", { bubbles: true });
    this.element.dispatchEvent(event);
  }

  handleSuccess(result) {
    const event = new CustomEvent("stripe:success", {
      bubbles: true,
      detail: result.token,
    });
    this.element.dispatchEvent(event);
  }

  get billingAddress() {
    return this.elementsController.billingAddress;
  }

  get style() {
    return merge(JSON.parse(this.data.get("style")), this.baseStyle);
  }

  get baseStyle() {
    return this.elementsController.style;
  }

  get clientSecret() {
    return this.elementsController.clientSecret;
  }

  get elements() {
    return this.stripe.elements();
  }

  get stripe() {
    return this.elementsController.stripe;
  }

  get elementsController() {
    return this.application.getControllerForElementAndIdentifier(
      this.stripeElementsElement,
      "shop--stripe--elements-component"
    );
  }

  get stripeElementsElement() {
    return this.element.closest(".Shop-Stripe-Elements");
  }
}

export default ElementComponent;
