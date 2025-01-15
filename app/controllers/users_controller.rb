class UsersController < ApplicationController
  def index
    @user = current_user
  end


  def edit
    @user = current_user
    @information = @user.information

  end
  
  def new
    @user = current_user
    @information = Information.new
  end

  def create

    @information = Information.new(item_params)
    if @information.save
    redirect_to users_path
    else   
    end
  end


  def update
    @information = current_user.information 
    if @information.update(item_params)
    redirect_to users_path
    else   
    end

  end


  private

  def item_params
    params.require(:information).permit(
      :last_name, :first_name, :last_name_kana, :first_name_kana,
      :post_code, :prefecture_id, :city, :address, :building,
      :phone_number, :birthday
    ).merge(user_id: current_user.id)
  end


end
