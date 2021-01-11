class Place < ApplicationRecord
  has_many :stages

  validates :name, :address, presence: true
  validates :latitude, numericality: true
  validates :longitude, numericality: true
  validates :name, uniqueness: true

end
