class Player < ActiveRecord::Base
  has_many :heroes
  has_many :matches
  has_one  :stats
end
