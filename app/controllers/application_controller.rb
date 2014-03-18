class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate if ENV["AUTHENTICATE"] == "true"
  before_filter :set_locale
  before_action :load_global_resources

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["HTTP_AUTH_USER"] && password == ENV["HTTP_AUTH_PASS"]
    end
  end

  def load_global_resources
    @about_category = PageCategory.find_by_id(1)
    @svt_category = PageCategory.find_by_id(2)
    @projects = Project.all
  end

  def set_locale
    # A hacky way to set activeadmin to english but keep rest of site in swedish
    # todo: find a cleaner way to do this
    I18n.locale = params[:controller].include?('admin/') ? :en : I18n.default_locale
  end
end
