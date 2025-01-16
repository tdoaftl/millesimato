class ClothingsController < ApplicationController
  def index
    @clothings = Clothing.all
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

  def show
    @clothing = Clothing.find(params[:id])
  end

  def edit
    @clothing = Clothing.find(params[:id])
  end

  def update
    @clothing = Clothing.find(params[:id])
    if @clothing.update(item_params)
      redirect_to clothing_path
    else
      
    end
  end  

  def destroy
    clothing = Clothing.find(params[:id])
    clothing.destroy
    redirect_to root_path 
  end

  private

  def item_params
    params.require(:clothing).permit(
      :item, :description, :price, :brand, :age, :category,
      :condition, :size, :color, :material
    ).merge(user_id: current_user.id)
  end


end
