class ClothingsController < ApplicationController
  def index
    if current_user&.admin?
       @clothings = Clothing.all
    end
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

  def search
    min_price = params[:min_price].to_i
    max_price = params[:max_price].to_i

    # 価格範囲に基づいて商品を検索
    @clothings = Clothing.where(price: min_price..max_price)

    # 商品の価格と画像URLだけを返す
    # 画像URLはrails_blob_pathを使って生成
    render json: @clothings.map { |clothing| {
      id: clothing.id,
      price: clothing.price,
      image_url: clothing.image.attached? ? rails_blob_path(clothing.image, only_path: true) : nil
    } }
  end

  private

  def item_params
    params.require(:clothing).permit(
      :item, :description, :price, :brand, :age, :category,
      :condition, :size, :color, :material, :image
    ).merge(user_id: current_user.id)
  end


end
