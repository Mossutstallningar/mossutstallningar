class SearchController < ApplicationController
  def index
    @projects = Project.search(params[:q])

    respond_to do |format|
      format.html
      format.json { render json: @projects }
    end
  end
end
