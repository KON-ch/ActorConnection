# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_admin!
  layout 'dashboard/dashboard'

  def index
    @posts = Post.all
  end
end
