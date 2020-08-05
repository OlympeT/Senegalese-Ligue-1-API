class Championship < ApplicationRecord
  has_many :games
  has_many :points
  validates :beginning, :end_saison, :presence => true
end
