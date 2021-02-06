class User < ApplicationRecord
  has_many :posts
  has_many :theaters
  has_many :movies
  has_many :stages
  has_many :reviews
  acts_as_liker
  has_one_attached :image

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  validates :profile, length: { maximum: 255, too_lonb: "最大%{count}文字まで入力できます" }
  validates :password, length: { in: 6..20 }, on: :update_password

  enum sex: { "男性": 0, "女性": 1, "秘密": 9}
  
  extend DisplayList
  extend SwitchFlg
  extend SortInfo

  default_scope -> { order(created_at: :desc)}

  def update_password(params, *options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end

end
