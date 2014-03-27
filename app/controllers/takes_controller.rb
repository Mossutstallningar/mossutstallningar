class TakesController < ApplicationController
  def index
    @takes = Take.published

    respond_to do |format|
      format.html
    end
  end

  def show
    @take = Take.friendly.find params[:id]

    respond_to do |format|
      format.html
    end
  end
end
