class Public::CartItemsController < ApplicationController
  before_action :authenticate_cutomer!
  before_action :customer_is_deleted

  def index
    @cart_items = current_customer.cart_items
    @total_price = @cart_items.sum(:price)
  end

  def create
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  private
  def items_params
    pramas.require(:cart_items).permit(:customer_id, :item_id, :amount, :price)
  end
end
