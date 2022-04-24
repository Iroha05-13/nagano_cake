class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
  end

  def complete
  end
end
