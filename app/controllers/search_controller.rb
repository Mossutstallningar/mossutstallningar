class SearchController < ApplicationController
  def index
    q = params[:q]

    if q.present?
      @result = Project.search(q) + Page.search(q) + Take.search(q)
    end

    respond_to do |format|
      format.html
      format.json { render json: @result }
    end
  end
end
