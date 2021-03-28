# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :country
  belongs_to :user
  has_many :movie_tags, dependent: :destroy
  has_many :tags, through: :movie_tags
  accepts_nested_attributes_for :movie_tags
  belongs_to :parent, class_name: 'Movie', optional: true

  acts_as_likeable

  validates :title, presence: true, uniqueness: { scope: :sub_title, message: 'この作品は既に作成されています' }

  validates :screen_time, numericality: { only_integer: true }, allow_nil: true

  extend DisplayList
  extend SortInfo

  scope :search_movies, lambda { |keyword|
    where('title LIKE ? OR supervision LIKE ? OR sub_title LIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
  }

  scope :sort_list, lambda {
    {
      '並び替え' => '',
      '投稿の新しい順' => 'updated_at_desc',
      '投稿の古い順' => 'updated_at_asc',
      '製作年の新しい順' => 'production_desc',
      '製作年の古い順' => 'production_asc'
    }
  }

  delegate :new, to: :reviews, prefix: true

  after_commit :create_post, on: [:create]

  private

  def create_post
    return if user_id == 1

    post = Post.new(movie_id: id, user_id: user_id)
    post.save
  end
end
