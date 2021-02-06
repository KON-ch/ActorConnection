class Country < ApplicationRecord
  has_many :theaters
  has_many :movies

  validates :name, presence: true, uniqueness: true, on: :create

end
