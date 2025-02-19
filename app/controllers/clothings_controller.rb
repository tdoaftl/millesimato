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
      render :new, status: :unprocessable_entity
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
      render :edit, status: :unprocessable_entity
    end
  end  

  def destroy
    clothing = Clothing.find(params[:id])
    clothing.destroy
    redirect_to root_path 
  end


  #ブランド名を検索してプルダウンリストに表示
  def brand_check
    query = params[:query].downcase # ユーザーの入力を小文字に変換
  
    # ActiveHash内のデータを小文字に変換し、前方一致するものを検索
    results = Brand.all.select do |brand|
      brand.name.downcase.start_with?(query) # 入力文字列で始まるブランドのみ取得
    end
  
    render json: results.map { |brand| { id: brand.id, name: brand.name } }
  end

    def search_all
      
      if current_user&.admin?  # ユーザーが管理者の場合
        clothings = Clothing.all
      else
        clothings = Clothing.where(visibility: :visible)  # 一般ユーザーまたは未ログインユーザーは visible の商品を表示
      end
    
      # フリーワード検索 (item または description)
      if params[:searchWord].present?
        query = params[:searchWord].strip.downcase
        clothings = clothings.where('LOWER(item) LIKE :query OR LOWER(description) LIKE :query', query: "%#{query}%")
      end
  
      # 金額範囲でフィルタ
      if params[:priceRange].present?
        min_price = params[:priceRange][:min].to_i
        max_price = params[:priceRange][:max].to_i
  
        clothings = clothings.where(price: min_price..max_price)
      end
  
      # チェックボックスフィルタ
      if params[:checkboxFilters].present?
        filters = params[:checkboxFilters]
  
        # ブランドフィルタ
        if filters[:brand].present?
          clothings = clothings.where(brand_id: filters[:brand].map(&:to_i))
        end
  
  
    
      # 性別でフィルタ
      if filters[:gender].present?
        clothings = clothings.where(gender_id: filters[:gender].map(&:to_i))
      end
    
      # 年代でフィルタ
      if filters[:era].present?
        clothings = clothings.where(era_id: filters[:era].map(&:to_i))
      end
    
      # カテゴリーでフィルタ
      if filters[:category].present?
        clothings = clothings.where(category_id: filters[:category].map(&:to_i))
      end
    
      # 素材でフィルタ
      if filters[:material].present?
        clothings = clothings.where(material_id: filters[:material].map(&:to_i))
      end
    
      # 製造国でフィルタ
      if filters[:made_in].present?
        clothings = clothings.where(made_in_id: filters[:made_in].map(&:to_i))
      end
    
      # 色でフィルタ
      if filters[:color].present?
        clothings = clothings.where(color_id: filters[:color].map(&:to_i))
      end
    
      # サイズでフィルタ
      if filters[:size].present?
        clothings = clothings.where(size_id: filters[:size].map(&:to_i))
      end
    
      # 状態でフィルタ
      if filters[:condition].present?
        clothings = clothings.where(condition_id: filters[:condition].map(&:to_i))
      end
    
    end
     # レスポンスが空でも空の配列を返す
    render json: clothings.map { |clothing|
      {
        id: clothing.id,
        price: clothing.price,
        image_url: clothing.image.attached? ? rails_blob_path(clothing.image, only_path: true) : nil,
        sold: clothing.sold?,
        invisible: clothing.invisible?

      }
    }
  
    end





    def toggle_visibility
      @clothing = Clothing.find(params[:id]) 
      if @clothing.update(visibility: params[:visibility])
        render json: { visibility: @clothing.visibility }
      else
        render json: { error: "更新に失敗しました" }, status: :unprocessable_entity
      end
    end


private

def item_params
  params.require(:clothing).permit(
    :item, :description, :price, :brand_id, :era_id, :gender_id, :category_id,
    :condition_id, :size_id, :color_id, :material_id, :made_in_id, :image, :visibility
  ).merge(user_id: current_user.id)
end


  
  
end