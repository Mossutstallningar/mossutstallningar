class StaticPagesController < ApplicationController
  skip_before_filter :check_for_closed, only: :closed

  def start
  end

  def closed
    render layout: false
  end
end
