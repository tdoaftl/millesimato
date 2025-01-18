class Gender < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'Mens' },
    { id: 3, name: 'Ladys' },
  ]

  include ActiveHash::Associations
  has_many :clothings
end