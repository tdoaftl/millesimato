class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.build(clothing_id: params[:clothing_id])
    favorite.save
    redirect_to clothing_path
  end

  def destroy
    favorite = Favorite.find_by(clothing_id: params[:clothing_id], user_id: current_user.id)
    favorite.destroy
    redirect_to clothing_path
  end
end
