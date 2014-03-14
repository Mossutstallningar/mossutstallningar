class SearchController < ApplicationController
  def index
    @result = Project.search(params[:q]) + Page.search(params[:q])

    respond_to do |format|
      format.html
      format.json { render json: @projects }
    end
  end
end
