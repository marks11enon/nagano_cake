class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
  end

  def create
    binding.pry
    @item =Item.find(cart_item_params[:item_id])
    @cart_item.price = @cart_item.item.price * @cart_item.amount
    @cart_item.save
    redirect_to cart_items_path
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  private
  def cart_item_params
    pramas.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end
