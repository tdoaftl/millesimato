class Color < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'ホワイト' },
    { id: 3, name: 'ブラック' },
    { id: 4, name: 'グレー' },
    { id: 5, name: 'ベージュ' },
    { id: 6, name: 'ネイビー' },
    { id: 7, name: 'ブラウン' },
    { id: 8, name: 'レッド' },
    { id: 9, name: 'ブルー' },
    { id: 10, name: 'グリーン' },
    { id: 11, name: 'イエロー' },
    { id: 12, name: 'パープル' },
    { id: 13, name: 'ピンク' },
    { id: 14, name: 'オレンジ' },
    { id: 15, name: 'カーキ' },
    { id: 16, name: 'ボルドー' },
    { id: 17, name: 'マスタード' },
    { id: 18, name: 'ラベンダー' },
    { id: 19, name: 'ペールトーン' },
    { id: 20, name: 'メタリック' },
    { id: 21, name: 'マルチ' },
  ]

  include ActiveHash::Associations
  has_many :clothings
 end