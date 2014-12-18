class Stats < ActiveRecord::Base
  belongs_to :players
  belongs_to :heroes
end
