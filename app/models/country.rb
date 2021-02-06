class Country < ApplicationRecord
  has_many :theaters, dependent: :nullify
  has_many :movies, dependent: :nullify

  validates :name, presence: true, uniqueness: true, on: :create
end
