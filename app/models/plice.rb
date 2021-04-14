class Plice < ApplicationRecord
  has_many :stage_plices, dependent: :destroy
  has_many :stages, through: :stage_plices

  validates :name, :fee, presence: true
  validates :name, :fee, numericality: { only_integer: true}
  
  enum name: {
    "一般": 0, 
    "夜料金": 1, 
    "高校生以下": 2, 
    "U25": 3, 
    "U30": 4, 
    "前売": 5, 
    "当日": 6, 
    "Ａ席": 7, 
    "Ｂ席": 8, 
    "Ｚ席": 9, 
    "学生料金": 10
  }

  def plice_name_and_fee
    self.name + '(' + self.fee.to_s + '円)'
  end

end
