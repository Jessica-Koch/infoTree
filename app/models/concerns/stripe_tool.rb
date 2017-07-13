module StripeTool
  def self.create_customer(email, stripe_token)
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
  end

  def self.create_charge( customer_id, amount, description)
    charge = Stripe::Charge.create(
      customer: customer.id, # This is NOT the application user_id
      amount: amount,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )
  end
end
