class ChargesController < ApplicationController
  before_action :authenticate_user!

  before_action :amount_to_be_charged
  def new
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "Premium Membership - #{current_user.first_name} #{current_user.last_name}",
      amount: @amount
    }
  end

  def create
    current_user.role = 'premium'

    if current_user.save!
      flash[:notice] = "Thanks for signing up #{current_user.email}!"
      redirect_to wikis_path
    end


    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong
    #
    # Rescue block catches and displays errors
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def thanks
  end
  private


  def amount_to_be_charged
    @amount = 500
  end
end
