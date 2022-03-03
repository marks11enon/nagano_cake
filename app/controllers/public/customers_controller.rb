class Public::CustomersController < ApplicationController
  def show
  end

  def edit
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana,
    :first_name_kana, :postal_code, :address, :telephone_number)
  end
end
