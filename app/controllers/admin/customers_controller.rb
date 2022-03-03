class Admin::CustomersController < ApplicationController
  # このcontrollerを記述する　3/3 private paramsが必要　indexも確認
  def index
    @customers = Customer.page(params[:page])
    @customer = Customer.new
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana,
    :first_name_kana, :postal_code, :address, :telephone_number)
  end
end
