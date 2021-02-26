class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :theaters, dependent: :nullify
  has_many :movies, dependent: :nullify
  has_many :stages, dependent: :nullify
  has_many :reviews, dependent: :destroy
  acts_as_liker
  has_one_attached :image

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :profile, length: { maximum: 255 }
  validates :password, length: { in: 6..20 }, on: :update_password

  enum sex: { "男性": 0, "女性": 1, "秘密": 9 }

  extend DisplayList
  extend SwitchFlg
  extend SortInfo

  scope :sort_list, lambda {
    {
      '並び替え' => '',
      '投稿の新しい順' => 'updated_at_desc',
      '投稿の古い順' => 'updated_at_asc'
    }
  }

  default_scope -> { order(created_at: :desc) }

  def update_password(params, *options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end

  def self.new_guest
    find_or_create_by(email: 'guest@example.com') do |user|
      user.name = 'ゲスト'
      user.birthday = '1991-01-01'
      user.sex = 9
      user.password = ENV['GUEST_PASS']
    end
  end
end
