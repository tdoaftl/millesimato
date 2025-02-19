class CreateDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :deliveries do |t|
      t.string      :last_name,         null: false
      t.string      :first_name,        null: false
      t.string      :last_name_kana,    null: false
      t.string      :first_name_kana,   null: false
      t.string      :post_code,         null: false
      t.integer     :prefecture_id,     null: false
      t.string      :city,              null: false
      t.string      :address,           null: false
      t.string      :building
      t.string      :phone_number,      null: false
      t.references  :purchase,          null: false, foreign_key: true

      t.timestamps
    end
  end
end
