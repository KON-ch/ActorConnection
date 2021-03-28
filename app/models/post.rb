# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  belongs_to :theater, -> { includes :country }, inverse_of: :posts, optional: true
  belongs_to :stage, -> { includes :theater }, inverse_of: :posts, optional: true
  belongs_to :movie, -> { includes :country }, inverse_of: :posts, optional: true
  belongs_to :like, optional: true
  belongs_to :review, -> { includes :user, :theater, :movie, :stage }, inverse_of: :posts, optional: true

  default_scope -> { order(created_at: :desc) }

  extend DisplayList

  delegate :new, to: :reviews, prefix: true
end
