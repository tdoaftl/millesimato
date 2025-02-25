class FavoritesController < ApplicationController
  def create
    @clothing = Clothing.find(params[:clothing_id])
    favorite = current_user.favorites.build(clothing: @clothing)
    favorite.save
    redirect_to clothing_path(@clothing)
  end

  def destroy
    @clothing = Clothing.find(params[:clothing_id])
    @favorite = current_user.favorites.find_by(clothing: @clothing)
  
    if @favorite
      @favorite.destroy

      if params[:from] == 'user'
        redirect_to   favorites_users_path  # マイページへ
      elsif params[:from] == 'item'
        redirect_to clothing_path(@clothing)  # アイテム詳細へ
      end
    end
  end



  def index
    @favorites = current_user.favorites 
    @favorite_clothings = current_user.favorite_clothings

  end
end
