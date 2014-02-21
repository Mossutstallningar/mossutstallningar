class PagesController < ApplicationController
  def start
    @projects = Project.all
  end
end
