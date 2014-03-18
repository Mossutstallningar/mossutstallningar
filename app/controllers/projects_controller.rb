class ProjectsController < ApplicationController
  def show
    @project = Project.friendly.find params[:id]

    respond_to do |format|
      format.html
      format.json { render json: @projects }
    end
  end
end
