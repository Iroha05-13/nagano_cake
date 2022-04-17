class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address = Address.new
  end

  def edit
    @addresse = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to addresses_path
    else
      render :index
    end
  end

  def update
    @addresse = Address.find(params[:id])
    if @address.update
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @addresse = Address.find(params[:id])
    if @address.destroy
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
