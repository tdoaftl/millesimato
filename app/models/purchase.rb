class Purchase < ApplicationRecord
  has_one :delivery
  belongs_to :clothing
end
