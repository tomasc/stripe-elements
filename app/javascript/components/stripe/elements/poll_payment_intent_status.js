const pollPaymentIntentStatus = async (
  paymentIntent,
  timeout = 30000,
  interval = 500,
  start = null
) => {
  start = start ? start : Date.now()
  const endStates = [
    "succeeded",
    "processing",
    "canceled",
    "requires_payment_method"
  ]
  // Retrieve the PaymentIntent status from our server.
  const rawResponse = await fetch(`payment_intents/${paymentIntent}/status`)
  const response = await rawResponse.json()
  const isTerminalState = paymentIntentTerminalState(response.paymentIntent)

  if (!isTerminalState && Date.now() < start + timeout) {
    // Not done yet. Let's wait and check again.
    setTimeout(
      pollPaymentIntentStatus,
      interval,
      paymentIntent,
      timeout,
      interval,
      start
    )
  } else {
    handlePayment(response)
    if (!isTerminalState) {
      // Status has not changed yet. Let's time out.
      console.warn(new Error("Polling timed out."))
    }
  }
}

export default pollPaymentIntentStatus
