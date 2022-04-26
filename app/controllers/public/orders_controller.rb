class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @address = Address.new
    @addresses = current_customer.addresses.all
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart_item.amount
        order_detail.price = cart_item.subtotal
        order_detail.save
      end
      redirect_to complete_path
      cart_items.destroy_all
    else
      @order = Order.new
      render :new
    end
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if params[:order][:address_number] == "1"
      @order.name = current_customer.name
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
    elsif params[:order][:address_number] == "2"
      if current_customer.addresses.find_by(id: params[:address])
        @order.name = Address.find(params[:address][:id]).name
        @order.postal_code = Address.find(params[:address][:id]).postal_code
        @order.address = Address.find(params[:address][:id]).address
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
    @total = 0
    @order.total_price = @total + @order.postage
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:name, :postal_code, :address, :total_price, :postage)
  end

  def address_params
    params.require(:order).permit(:name, :postal_code, :address)
  end
end
