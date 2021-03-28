# frozen_string_literal: true

class MovieTag < ApplicationRecord
  belongs_to :movie
  belongs_to :tag

  validates :movie_id, uniqueness: { scope: :tag_id }
end
