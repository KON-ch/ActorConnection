class WebsController < ApplicationController
  def index
    @movies = Movie.order(likers_count: :desc).limit(6)
    @review = nil
    @stages = Stage.where('extract(month from end_date) = ?', Date.current.month).order(start_date: :asc).limit(4)
    @tags = Tag.all.limit(12)
  end
end
