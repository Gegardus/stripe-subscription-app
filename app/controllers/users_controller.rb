class UsersController < ApplicationController
  before_action :authenticate_user!

  def info
    @subscription = current_user.subscription 
  end

  def cancel_subscription
    subscription = Stripe::Subscription.retrieve(current_user.subscription.subscription_id)
    subscription.cancel   
    current_user.subscription.active = false
    current_user.subscription.save

    redirect_to users_info_path 
  end

  def charge
    token = params["stripeToken"]

    customer = Stripe::Customer.create({
      :email => current_user.email,
      :source => token
    })

    subscription = Stripe::Subscription.create({
      :customer => customer.id,
      :items => [{:plan => 'subscription_app_bronz'}]
    })

    subscription = Stripe::Subscription.retrieve(subscription.id)
    current_user.subscription.subscription_id = subscription.id  

    current_user.subscription.stripe_user_id = customer.id
    current_user.subscription.active = true
    current_user.subscription.save

    redirect_to users_info_path
  end
end
