# frozen_string_literal: true

class Theater < ApplicationRecord
  has_many :stages, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :posts, dependent: :destroy
  belongs_to :country, optional: true
  belongs_to :user

  acts_as_likeable

  validates :title, :writer, presence: true
  validates :title, presence: true, uniqueness: { scope: :writer, message: 'この作品は既に作成されています' }
  validates :man, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :female, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  extend DisplayList
  extend SortInfo

  scope :search_theaters, lambda { |keyword|
    where('title LIKE ? OR writer LIKE ?', "%#{keyword}%", "%#{keyword}%")
  }

  scope :sort_list, lambda {
    {
      '並び替え' => '',
      '投稿の新しい順' => 'updated_at_desc',
      '投稿の古い順' => 'updated_at_asc'
    }
  }

  delegate :new, to: :reviews, prefix: true

  after_commit :create_post, on: [:create]

  private

  def create_post
    return if user_id == 1

    post = Post.new(theater_id: id, user_id: user_id)
    post.save
  end
end
