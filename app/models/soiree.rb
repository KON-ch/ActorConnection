# frozen_string_literal: true

class Soiree < ApplicationRecord
  has_many :soiree_stages, dependent: :destroy
  has_many :stages, through: :soiree_stages

  validates :performance_date, presence: true
  validates :performance_date, uniqueness: true
end
