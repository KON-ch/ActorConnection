class TheatersController < ApplicationController
  def index
    @theaters = Theater.all
  end

  def show
  end

  def new
    @theater = Theater.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
