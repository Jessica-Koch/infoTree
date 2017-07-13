class ChargesController < ApplicationController
  before_action :amount_to_be_charged
  def new
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:stripe_public_key]}",
      description: "Premium Membership - #{current_user.first_name} #{current_user.last_name}",
      amount: @amount
    }
  end

  def create
    @amount = 500
    # create stripe customer object to associate with the charge
    customer = StripeTool.create_customer(email: params[:stripeEmail],
    stripe_token: params[:stripeToken])

    charge = StripeTool.create_charge(customer_id: customer.id,
      amount: @amount,
    description: 'Rails Stripe customer')



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

  private
  def amount_to_be_charged
    @amount = 500
  end
end
