class CreateClothings < ActiveRecord::Migration[7.0]
  def change
    create_table :clothings do |t|
      t.string      :item,          null: false
      t.string      :description,   null: false
      t.integer     :price,         null: false
      t.string      :brand,         null: false
      t.string      :age,           null: false
      t.string      :category,      null: false
      t.string      :condition,     null: false
      t.string      :size,          null: false
      t.string      :color,         null: false
      t.string      :material,      null: false
      t.references  :user,          null: false, foreign_key: true

      t.timestamps
    end
  end
end
