class MatineeStage < ApplicationRecord
  belongs_to :matinee
  belongs_to :stage

  validates :stage_id, uniqueness: { scope: :matinee_id }
end
