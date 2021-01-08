class Stage < ApplicationRecord
  belongs_to :theater

  extend DisplayList
  scope :sort_stages, -> (sort_order, page) { order(sort_order[:sort]).display_list(page) }

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
