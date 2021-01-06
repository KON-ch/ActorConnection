class WebController < ApplicationController
  def index
    @theaters = Theater.all
  end
end
