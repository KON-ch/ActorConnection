# frozen_string_literal: true

module Dashboard
  class TagsController < ApplicationController
    layout 'dashboard/dashboard'
    def index
      @tags = Tag.all
      @tag_new = Tag.new
    end

    def create
      tag = Tag.new(tag_params)
      tag.save
      redirect_to dashboard_tags_path
    end

    def destroy
      tag = Tag.find(params[:id])
      tag.destroy
      redirect_to dashboard_tags_path
    end

    private

    def tag_params
      params.require(:tag).permit(:name)
    end
  end
end
