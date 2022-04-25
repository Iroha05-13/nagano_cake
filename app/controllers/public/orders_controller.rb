class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @address = Address.new
    @addresses = Address.all
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      
    

  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_number] == "1"
      @order.name = current_customer.name
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
    elsif params[:order][:address_number] == "2"
      if Address.exists?(name: params[:order][:address_id])
        @order.name = Address.find(params[:order][:address_id]).name
        @order.postal_code = Address.find(params[:order][:address_id]).postal_code
        @order.address = Address.find(params[:order][:address_id]).address
      else
        render :new
      end
    elsif params[:order][:address_number] == "3"
      address_new = current_customer.address.new(address_params)
      if address_new.save
      else
        render :new
      end
    else
      redirect_to new_order_path
    end

    @cart_items = current_customer.cart_items.all
    @total_price = 0
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:name, :postal_code, :address)
  end

  def address_params
    params.require(:order).permit(:name, :postal_code, :address)
  end
end
