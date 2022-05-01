class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = Order.find(params[:id])
    if @order_detail.update(detail_params)
      redirect_to admin_order_path(@order.id)
    else
      @order = Order.find(params[:id])
      render :show
    end
  end

  private
  def detail_params
    params.require(:order_detail).permit(:order_id, :making_status)
  end

end
