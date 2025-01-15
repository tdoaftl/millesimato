class CreateClothings < ActiveRecord::Migration[7.0]
  def change
    create_table :clothings do |t|

      t.timestamps
    end
  end
end
