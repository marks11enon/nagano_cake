class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @address = Address.new
    @addresses = current_customer.addresses.page(params[:page]).per(3)
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save!
    redirect_to addresses_path
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    address = Address.find(params[:id])
    if address.update(address_params)
      redirect_to addresses_path
      flash[:success] = "更新に成功しました"
    else
      flash[:success] = "入力内容を確認してください"
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    flash[:success] = "削除に成功しました"
    redirect_to addresses_path
  end

  private
  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end
end
