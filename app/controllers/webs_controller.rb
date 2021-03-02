class WebsController < ApplicationController
  def index
    @movies = Movie.order(likers_count: :desc).limit(6)
    @review = nil
    @stages = Stage.where('end_date > ?', Date.today).order(start_date: :asc).limit(4)
    @tags = Tag.all.limit(12)
  end
end
