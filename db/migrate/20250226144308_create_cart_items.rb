class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :clothing, null: false, foreign_key: true

      t.timestamps
    end
     # 同じカート内で同じ商品を複数追加できないようにする
     add_index :cart_items, [:cart_id, :clothing_id], unique: true
  end
end
