class ChargesController < ApplicationController

  def new
  end

  def create
    customer = Stripe::Customer.create(
      :email => nil,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => Integer(current_order.subtotal_cents),
      :description => "Order ##{current_order.id}",
      :currency    => 'usd'
    )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path
  end



end
