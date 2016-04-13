class Player < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2 }
  
  has_many :heroes
  has_many :matches
  has_one  :stats
end
