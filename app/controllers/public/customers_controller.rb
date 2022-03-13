class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  # show edit update は　current_customerで対応可能
  # unsubscribe withdrawは Customer.find_by(email: session[:email])で対応可能
  # current_customer　にて統一
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:success] = "登録情報を変更しました。"
      redirect_to customers_my_page_path
    else
      render 'edit'
    end
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer

    @customer.update(is_deleted: true)
    reset_session # ログアウト
    redirect_to root_path
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana,
    :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
  end
end
