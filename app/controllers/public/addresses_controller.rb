class Public::AddressesController < ApplicationController
  def index
    @addresses = current_customer.addresses.all
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:notice1] = "配送先を追加しました。"
      redirect_to addresses_path
    else
      @addresses = Address.all
      render :index
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice1] = "配送先を更新しました。"
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    if @address.destroy
      flash[:notice1] = "配送先が削除されました。"
      redirect_to addresses_path
    else
      render :index
    end
  end

  private
  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end
end
