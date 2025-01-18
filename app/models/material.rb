class Material < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'コットン' },
    { id: 3, name: 'ウール' },
    { id: 4, name: 'リネン' },
    { id: 5, name: 'シルク' },
    { id: 6, name: 'ウール' },
    { id: 7, name: 'ナイロン' },
    { id: 8, name: 'レザー' }
  ]

  include ActiveHash::Associations
  has_many :clothings
 end