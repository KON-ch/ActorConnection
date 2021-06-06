# frozen_string_literal: true

class Stage < ApplicationRecord
  belongs_to :theater
  has_many :posts, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :soiree_stages, dependent: :destroy
  has_many :soirees, through: :soiree_stages
  accepts_nested_attributes_for :soiree_stages
  has_many :matinee_stages, dependent: :destroy
  has_many :matinees, through: :matinee_stages
  accepts_nested_attributes_for :matinee_stages
  has_many :stage_tags, dependent: :destroy
  has_many :tags, through: :stage_tags
  accepts_nested_attributes_for :stage_tags
  has_many :stage_plices, dependent: :destroy
  has_many :plices, through: :stage_plices
  accepts_nested_attributes_for :stage_plices
  belongs_to :place, optional: true
  belongs_to :user

  acts_as_likeable

  validates :start_date, :end_date, :company, presence: true
  validates :theater_id, presence: true, uniqueness: { scope: :start_date, message: 'この作品は既に作成されています' }

  extend DisplayList
  extend SortInfo

  scope :this_month, -> { where('extract(month from end_date) = ?', Date.current.month) }
  scope :last_month, -> { where('extract(month from end_date) = ?', Date.current.last_month.month) }
  scope :next_month, -> { where('extract(month from end_date) = ?', Date.current.next_month.month) }

  scope :sort_list, lambda {
    {
      '並び替え' => '',
      '開演日が近い順' => 'start_date_asc',
      '開演日が遠い順' => 'start_date_desc',
      '終演日が近い順' => 'end_date_asc',
      '終演日が遠い順' => 'end_date_desc'
    }
  }

  after_commit :create_post, on: [:create]

  private

  def create_post
    return if user_id == 1

    post = Post.new(stage_id: id, user_id: user_id)
    post.save
  end
end
