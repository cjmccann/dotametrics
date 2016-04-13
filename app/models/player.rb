class Player < ActiveRecord::Base
  validates :steamid, presence: true, 
            uniqueness: true, length: { minimum: 5 }

  has_many :heroes
  has_many :matches
  has_one :stats

  def identifier 
    username.nil? ? steamid : username
  end
end
