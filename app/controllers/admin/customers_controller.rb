class Admin::CustomersController < ApplicationController
  # このcontrollerを記述する　3/3 private paramsが必要　indexも確認
  def index
    @customers = Customer.all
    @customer = Customer.new
  end

  def show
  end

  def edit
  end

  def update
  end
end
