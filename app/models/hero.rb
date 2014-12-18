class Hero < ActiveRecord::Base
  belongs_to :players
  has_one :stats
end
