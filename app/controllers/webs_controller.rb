class WebsController < ApplicationController
  def index
    @stage = Stages.last
  end
end
