# frozen_string_literal: true

class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    stages = @tag.stages
    @stage_review = current_user.reviews.stages(stages)
    movies = @tag.movies
    @movie_review = current_user.reviews.movies(movies)
  end
end
