# frozen_string_literal: true

class SoireeStage < ApplicationRecord
  belongs_to :soiree
  belongs_to :stage

  validates :stage_id, uniqueness: { scope: :soiree_id }
end
