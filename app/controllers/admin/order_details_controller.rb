class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

	def update
		@order_detail = OrderDetail.find(params[:id])
		@order = @order_detail.order
		@order_detail.update(order_detail_params)
		# @order_item = Order.OderItem.find(params[:id])
		# @order_item.update(order_item_params)

		if @order_item.making_status == "製作中" #製作ステータスが「製作作中」なら入る
			@order.update(order_status: 2)

		elsif @order.order_details.count ==  @order.order_details.where(making_status: "製作完了").count
			@order.update(order_status: 3) #注文ステータスを「発送準備中]に更新
		end
		redirect_to admin_order_path(@order_detail.order)
	end

	private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
