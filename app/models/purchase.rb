class Purchase < ApplicationRecord
  has_one :delivery
  belongs_to :clothing
  belongs_to :user
end
