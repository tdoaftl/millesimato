class Era < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '50s' },
    { id: 3, name: '60s' },
    { id: 4, name: '70s' },
    { id: 5, name: '80s' },
    { id: 6, name: '90s' },
    { id: 7, name: '00s' },
    { id: 8, name: '10s' },
  ]

  include ActiveHash::Associations
  has_many :clothings
 end