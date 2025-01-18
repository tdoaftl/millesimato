class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'Tシャツ' },
    { id: 3, name: 'L/S Tシャツ' },
    { id: 4, name: 'シャツ' },
    { id: 5, name: 'ジャケット' },
    { id: 6, name: 'ブルゾン' },
    { id: 7, name: 'コート' },
    { id: 8, name: 'パーカー' },
    { id: 9, name: 'スウェット' },
    { id: 10, name: 'セーター' },
    { id: 11, name: 'カーディガン' },
    { id: 12, name: 'チノ' },
    { id: 13, name: 'デニム' },
    { id: 14, name: 'スラックス' },
  ]

  include ActiveHash::Associations
  has_many :clothings
 end