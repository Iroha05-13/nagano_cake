class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items.all #ログイン中のユーザーのカートのみ
    @total = 0
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      flash[:notice] = "商品をカートに追加しました。"
      redirect_to cart_items_path
    elsif @cart_item.save
      flash[:notice] = "商品をカートに追加しました。"
      redirect_to cart_items_path
    else
      render :index
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash[:notice] = "カートを更新しました。"
      redirect_to cart_items_path
    else
      render :index
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    if @cart_item.destroy
      flash[:notice] = "カートから商品を削除しました。"
      redirect_to cart_items_path
    else
      render :index
    end
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    flash[:notice] = "カートからすべての商品を削除しました。"
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
