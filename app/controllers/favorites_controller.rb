class FavoritesController < ApplicationController
  def create
    @clothing = Clothing.find(params[:clothing_id])
    favorite = current_user.favorites.build(clothing_id: params[:clothing_id])
    favorite.save
    redirect_to clothing_path(@clothing.id)
  end

  def destroy
    clothing = Clothing.find(params[:clothing_id])
    favorite = current_user.favorites.find_by(clothing_id: clothing.id)

    if favorite
      favorite.destroy
    end

    redirect_to clothing_path(clothing.id)
  end

  def index
    @favorite_clothings = current_user.favorite_clothings

  end
end
