class Public::ItemsController < ApplicationController
  def index
    if params["genre"]
      @items = Item.active.where(genre_id: params["genre"]).page(params[:page]).per(8)
    else
      @items = Item.active.page(params[:page]).per(8)
    end
    @genres = Genre.all
    @items_all = Item.all
    @quantity = Item.count
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new(item_id: @item.id)
    @genres = Genre.all
  end

  private
  # ストロングパラメータ
  def item_params
    params.require(:item).permit(:name, :image, :introduction, :genre_id)
  end
end
