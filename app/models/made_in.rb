class MadeIn < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'USA' },
    { id: 3, name: 'Japan' },
    { id: 4, name: 'UK' },
    { id: 5, name: 'Italy' },
    { id: 6, name: 'France' },
    { id: 7, name: 'Germany' },
  ]

  include ActiveHash::Associations
  has_many :clothings
 end