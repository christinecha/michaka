class OrderItemsController < ApplicationController

  def create
    @order = current_order
    @order_item = @order.order_items.create(order_item_params)
    @order.save
    render :js => "window.location = '/cart';"
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
    redirect_to carts_path
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
  end
private
  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
