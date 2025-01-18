class Condition < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '未使用品' },
    { id: 3, name: '優良品' },
    { id: 4, name: '良品' },
    { id: 5, name: '普通' },
    { id: 6, name: 'やや使用感あり' },
    { id: 7, name: '使用感あり' },
    { id: 8, name: '可' },
  ]

  include ActiveHash::Associations
  has_many :clothings
 end