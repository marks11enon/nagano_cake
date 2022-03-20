class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    # カートに入っている商品の合計金額
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def create
    @item =Item.find(cart_item_params[:item_id])
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.item_id = params[:item_id]

    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])

      @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.amount += params[:cart_item][:amount].to_i
      @cart_item.update(amount: @cart_item.amount)
			redirect_to cart_items_path

    elsif @cart_item.save
      flash[:notice] = "#{@cart_item.item.name}をカートに追加しました。"
      redirect_to cart_items_path
    else
      flash[:alert] = "個数を選択してください"
      render "/items/show"
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path

  end

  # カート商品1つのみ削除
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash.now[:alert] = "#{@cart_item.item.name}を削除しました"
    redirect_to cart_items_path
  end

 # カートを空にする
  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    flash[:alert] = "カートの商品を全て削除しました"
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end
