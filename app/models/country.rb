class Country < ApplicationRecord
  has_many :theaters
  has_many :movies

  validates :name, presence: true, uniqueness: true

  scope :request_country, -> (country) { find(country.to_i) }

end
