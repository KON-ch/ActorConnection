class StagePlice < ApplicationRecord
  belongs_to :stage
  belongs_to :plice

  validates :stage_id, uniqueness: { scope: :plice_id }
end
