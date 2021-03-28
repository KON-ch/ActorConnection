# frozen_string_literal: true

class StageTag < ApplicationRecord
  belongs_to :stage
  belongs_to :tag

  validates :stage_id, uniqueness: { scope: :tag_id }
end
