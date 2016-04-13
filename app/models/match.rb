class Match < ActiveRecord::Base
  validates :match_id, presence: true, 
            uniqueness: true, length: { minimum: 5 }

  has_many :heroes
  has_and_belongs_to_many :players
  has_one :stats
end
