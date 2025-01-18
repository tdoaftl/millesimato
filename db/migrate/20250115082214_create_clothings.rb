class CreateClothings < ActiveRecord::Migration[7.0]
  def change
    create_table :clothings do |t|
      t.string      :item,             null: false
      t.string      :description,      null: false
      t.integer     :price,            null: false
      t.integer     :brand_id,         null: false
      t.integer     :era_id,           null: false
      t.integer     :gender_id,         null: false
      t.integer     :category_id,      null: false
      t.integer     :condition_id,     null: false
      t.integer     :size_id,          null: false
      t.integer     :color_id,         null: false
      t.integer     :material_id,      null: false
      t.integer     :made_in_id,       null: false
      t.references  :user,             null: false, foreign_key: true

      t.timestamps
    end
  end
end
