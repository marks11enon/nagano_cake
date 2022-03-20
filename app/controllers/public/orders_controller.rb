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
    @order = Order.new(order_params) #初期化代入
    @order.customer_id = current_customer.id #customer_idの代入
    @order.save

    # order_detailsの保存
    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.price = cart_item.item.price #税抜価格で保存
      @order_detail.order_id = @order.id
      @order_detail.save
    end

    binding.pry

    current_customer.cart_items.destroy_all
    redirect_to complete_path
  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
		@order_details = @order.order_details
  end

  private
  def order_params
    params.require(:order).permit(:payment, :address, :postage, :postal_code, :name, :total)
  end

end
