# frozen_string_literal: true

module StagesHelper
  def tag_movies(tag_id)
    movie_ids = MovieTag.where(tag_id: tag_id).limit(3).pluck(:movie_id)
    Movie.preload(:country, :movie_tags, :tags, :reviews).find(movie_ids)
  end
end
