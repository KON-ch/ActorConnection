class Tag < ApplicationRecord
  has_many :stage_tags, dependent: :destroy
  has_many :stages, through: :stage_tags
  has_many :movie_tags, dependent: :destroy
  has_many :movies, through: :movie_tags
end
