class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "Premium Membership - #{current_user.first_name} #{current_user.last_name}",
      amount: Amount.default
    }
  end

  def create
    @amount = 500
    # create stripe customer object to associate with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id, # This is NOT the application user_id
      amount: Amount.default,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thanks for signing up #{current_user.email}!"
    redirect_to user_path(current_user)

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong
    #
    # Rescue block catches and displays errors
  rescue Stripe::CardErrors => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end
end
