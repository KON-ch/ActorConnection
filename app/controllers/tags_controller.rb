# frozen_string_literal: true

class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @tag_stages = @tag.stages.preload(:theater, :place, :stage_tags, :tags, :reviews)
    @tag_movies = @tag.movies.preload(:country, :movie_tags, :tags, :reviews)
    stages = @tag.stages
    @stage_review = current_user&.reviews.stages(stages)
    movies = @tag.movies
    @movie_review = current_user&.reviews.movies(movies)
  end
end
