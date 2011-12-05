class Roster < ActiveRecord::Base
  belongs_to :post
  belongs_to :games

  scope :playernogame, where(:flags => "0")
end
