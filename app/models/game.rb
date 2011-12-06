class Game < ActiveRecord::Base
  belongs_to :post

  scope :complete, order("games.playerrank desc")
  scope :showdata, order("games.playerrank")
end
