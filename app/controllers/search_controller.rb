class SearchController < ApplicationController
  def index
    q = params[:q]

    @result = Project.search(q) + Page.search(q) if q.present?

    respond_to do |format|
      format.html
      format.json { render json: @result }
    end
  end
end
