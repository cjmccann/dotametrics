class Match < ActiveRecord::Base
  belongs_to :players
  has_many :hero_records
end
