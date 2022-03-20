class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @items = Item.active.all
  end

  def about
  end
end