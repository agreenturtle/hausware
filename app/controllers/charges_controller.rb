class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create(
      email: 'example@stripe.com',
      card: params[:stripeToken],
      metadata: {  }
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'usd'
    )
    
    
    redirect_to root_path, notice: "Successful checkout for $5"

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
