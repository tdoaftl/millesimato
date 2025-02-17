class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :clothing, foreign_key: true
      t.timestamps
    end
  end
end
