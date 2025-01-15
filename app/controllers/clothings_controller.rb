class ClothingsController < ApplicationController
  def index
  end

  def new
    @clothing = Clothing.new
  end

  def create
    @clothing = Clothing.new(item_params)
    if @clothing.save
    redirect_to root_path
    else   
    end
  end

  private

  def item_params
    params.require(:clothing).permit(
      :item, :description, :price, :brand, :age, :category,
      :condition, :size, :color, :material
    ).merge(user_id: current_user.id)
  end


end
