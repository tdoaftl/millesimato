class CreateInformation < ActiveRecord::Migration[7.0]
  def change
    create_table :information do |t|
      t.string      :last_name
      t.string      :first_name
      t.string      :last_name_kana
      t.string      :first_name_kana
      t.string      :post_code
      t.integer     :prefecture_id
      t.string      :city
      t.string      :address
      t.string      :building
      t.string      :phone_number
      t.references  :user,              null: false, foreign_key: true

      t.timestamps
    end
  end
end
