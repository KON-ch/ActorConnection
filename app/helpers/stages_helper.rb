# frozen_string_literal: true

module StagesHelper
  def tag_movies(tag_id)
    movie_ids = MovieTag.where(tag_id: tag_id).limit(3).pluck(:movie_id)
    Movie.preload(:country, :movie_tags, :tags, :reviews).find(movie_ids)
  end

  def stage_playing(stage)
    stage.start_date <= Date.today && stage.end_date >= Date.today
  end

  def stage_finished(stage)
    stage.end_date < Date.today
  end

  def stage_14days_ago(stage)
    stage.start_date - Date.today <= 14 && stage.start_date - Date.today > 0
  end
end
