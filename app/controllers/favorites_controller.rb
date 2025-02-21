class FavoritesController < ApplicationController
  def create
    @clothing = Clothing.find(params[:clothing_id])
    favorite = current_user.favorites.build(clothing_id: params[:clothing_id])
    favorite.save
    redirect_to clothing_path(@clothing.id)
  end

  def destroy
    @clothing = Clothing.find(params[:clothing_id])
    favorite = Favorite.find_by(clothing_id: params[:clothing_id], user_id: current_user.id)
    favorite.destroy
    redirect_to clothing_path(@clothing.id)
  end

  def index
    @clothing = Clothing.find(params[:clothing_id])
    @favorite_clothings = current_user.favorite_clothings
  end
end
