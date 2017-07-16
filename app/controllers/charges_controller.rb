require 'pry'

class ChargesController < ApplicationController
  before_action :amount_to_be_charged
  before_action :set_description
  before_action :set_plan
  before_action :authenticate_user!
  def new

  end

  def create
    if params[:subscription].include? 'yes'
      StripeTool.create_membership(email: params[:stripeEmail],
      stripe_token: params[:stripeToken], plan: @plan)
    else
      customer = StripeTool.create_customer(email: params[:stripeEmail],
      stripe_token: params[:stripeToken])
      charge = StripeTool.create_subscription(customer_id: customer.id, plan: @plan)
    end
    if current_user.save!
      current_user.role = 'premium'
      current_user.stripe_customer_id = customer.id
      current_user.save!
      flash[:notice] = "Thanks for signing up #{current_user.email}!"
      redirect_to wikis_path
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def cancel_plan
    @user = current_user

    if params[:action] == 'cancel_plan'
      customer = Stripe::Customer.retrieve(id: current_user.stripe_customer_id)

      sub_id = customer.subscriptions.first.id
      sub = Stripe::Subscription.retrieve(sub_id)
      sub.delete
      @user.role = 'standard'
      @user.save!

      make_wikis_public(@user)
      flash[:notice] = "Canceled subscription."
      redirect_to root_path
    else
      flash[:error] = "There was an error canceling your subscription. Please notify us."
      redirect_to edit_user_registration_path
    end
  end

  private

  def set_description
    @description = "Premium Membership"
  end

  def amount_to_be_charged
    @amount = 2999
  end

  def set_plan
    @plan = 9999
  end
end
