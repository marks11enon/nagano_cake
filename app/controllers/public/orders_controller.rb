class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)

    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:address_option] == "1"
      # view で定義している address_number が"1"だったときにこの処理を実行します
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name

    elsif params[:order][:address_option] == "2"
      # view で定義している address_number が"2"だったときにこの処理を実行します
      @address = Address.new(customer_id: current_customer.id)
        @address.postal_code = @order.postal_code
        @address.address =@order.address
        @address.name = @order.name
      if @address.save
        @order.postal_code =  @address.postal_code
        @order.address =  @address.address
        @order.name = @address.name

      binding.pry
      else
        render 'new'
      end
    else
      redirect_to cart_items_path
    end
    @cart_items = current_customer.cart_items.all # カートアイテムの情報をユーザーに確認してもらうために使用します
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def create
    cart_items = current_customer.cart_items.all
    # ログインユーザーのカートアイテムをすべて取り出して cart_items に入れます
    @order = current_customer.orders.new(order_params)
    # 渡ってきた値を @order に入れます
    if @order.save
    # ここに至るまでの間にチェックは済ませていますが、念の為IF文で分岐させています
      cart_items.each do |cart|
      # 取り出したカートアイテムの数繰り返します
      # order_item にも一緒にデータを保存する必要があるのでここで保存します
      order_detail = OrderDetail.new
      order_detail.item_id = cart.item_id
      order_detail.order_id = @order.id
      order_detail.amount = cart.amount
      # 購入が完了したらカート情報は削除するのでこちらに保存します
      order_detail.price = cart.item.price
      # カート情報を削除するので item との紐付けが切れる前に保存します
      order_detail.save
      end
      redirect_to complete_path
      cart_items.destroy_all
      # ユーザーに関連するカートのデータ(購入したデータ)をすべて削除します(カートを空にする)
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
		@order_detail = @order.order_detail
  end

  private
  def order_params
    params.require(:order).permit(:payment, :address, :postage, :postal_code, :name, :total)
  end

end
