class ProjectsController < ApplicationController
  def show
    @page = Project.find params[:id]

    respond_to do |format|
      format.html
      format.json { render json: @page }
    end
  end
end
