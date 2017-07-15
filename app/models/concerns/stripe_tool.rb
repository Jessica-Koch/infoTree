module StripeTool
  def self.create_customer(email: email, stripe_token: stripe_token)
    Stripe::Customer.create(
      email: email,
      source: stripe_token
    )
  end

  def self.create_membership(email: email, stripe_token: stripe_token, plan: plan)
    Stripe::Customer.create(
      email: email,
      source: stripe_token,
      plan: plan
    )
  end

  def self.create_subscription(customer_id: customer_id, plan: plan)
    Stripe::Subscription.create(
      customer: customer_id,
      plan: plan
    )
  end

  def self.cancel_subscription(email: email, customer_id: customer_id, stripe_token: stripe_token, plan: plan )
    customer = Stripe::Customer.retrieve(customer_id: customer_id)
    sub = customer.subscriptions.retrieve(plan: plan)
    sub.delete
  end
end
