class Stage < ApplicationRecord
  belongs_to :theater
  has_one :post, dependent: :destroy, touch: true
  belongs_to :place

  validates :start_date, :end_date, :company, presence: true
  validates :theater_id, presence: true, uniqueness: {scope: :start_date, message:"この作品は既に作成されています"}

  extend DisplayList
  extend SortInfo

  scope :sort_list, -> {
    {
      "並び替え" => "",
      "開演日が近い順" => "start_date asc",
      "開演日が遠い順" => "start_date desc",
      "終演日が近い順" => "end_date asc",
      "終演日が遠い順" => "end_date desc",
    }
  }
end
