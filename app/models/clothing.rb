class Clothing < ApplicationRecord
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :brand
  belongs_to :era
  belongs_to :gender
  belongs_to :category
  belongs_to :condition
  belongs_to :size
  belongs_to :color
  belongs_to :material
  belongs_to :made_in


end
