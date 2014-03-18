class PagesController < ApplicationController
  def show
    @page = Page.friendly.find params[:id]

    respond_to do |format|
      format.html
      format.json { render json: @page }
    end
  end
end
