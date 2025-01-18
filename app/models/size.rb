class Size < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'XS' },
    { id: 3, name: 'S' },
    { id: 4, name: 'M' },
    { id: 5, name: 'L' },
    { id: 6, name: 'XL' },
  ]

  include ActiveHash::Associations
  has_many :clothings
 end