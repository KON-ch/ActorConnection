class Place < ApplicationRecord
  has_many :stages

  validates :name, :address, presence: true
  validates :latitude, :longitude, numericality: true
  validates :name, uniqueness: true

end
