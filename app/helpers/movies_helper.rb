# frozen_string_literal: true

module MoviesHelper
  def tag_stages(tag_id)
    stage_ids = StageTag.where(tag_id: tag_id).limit(3).pluck(:stage_id)
    Stage.preload(:theater, :place, :tags, :reviews).find(stage_ids)
  end
end
