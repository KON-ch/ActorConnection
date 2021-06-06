class Matinee < ApplicationRecord
  has_many :matinee_stages, dependent: :destroy
  has_many :stages, through: :matinee_stages

  validates :performance_date, presence: true
  validates :performance_date, uniqueness: true
end
