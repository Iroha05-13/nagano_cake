class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
    @cart_items = current_customer.cart_items.all
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)

    if @order.save
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart_item.amount
        order_detail.price = cart_item.item.with_tax_price
        order_detail.making_status = OrderDetail.making_statuses.key(0)

        order_detail.save
      end
      redirect_to complete_path
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.name = current_customer.name
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.name = @address.name
      @order.postal_code = @address.postal_code
      @order.address = @address.address
    elsif params[:order][:select_address] == "2"
      @order.save
    else
      render :new
    end

    @cart_items = current_customer.cart_items.all
    @total = 0
    @cart_items.each do |cart_item|
      cart_item.subtotal
      @total += cart_item.subtotal
    end
    @order.total_price = @total + @order.postage
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:name, :postal_code, :address, :payment, :status, :total_price, :postage)
  end
end
