class User < ApplicationRecord
  has_many :reviews
  has_many :theaters
  has_many :stages
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  acts_as_liker

  enum sex: { "男性": 0, "女性": 1, "秘密": 9}
  
  extend DisplayList
  extend SwitchFlg
  extend SortOrder


  scope :sort_list, -> {
    {
      "並び替え" => "",
      "登録の新しい順" => "created_at desc",
      "登録の古い順" => "created_at asc",
    }
  }

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
