class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale
  before_filter :fix_caching_problem
  before_filter :check_for_closed if ENV['CLOSED'] == 'true'
  before_action :load_global_resources

  helper_method :in_admin?

  # http://erlingur.is/post/68977749545/safari-7-blank-page-problem
  def fix_caching_problem
    headers['Last-Modified'] = Time.now.httpdate
  end

  def check_for_closed
    unless user_signed_in? || in_admin?
      redirect_to closed_url, status: 302
    end
  end

  def load_global_resources
    unless in_admin?
      @about_category = PageCategory.find_by_id(1)
      @svt_category = PageCategory.find_by_id(2)
      @projects = Project.published.order_by_position
      @settings = SiteSettings.new Setting.all
    end
  end

  def set_locale
    # A hacky way to set activeadmin to english but keep rest of site in swedish
    # todo: find a cleaner way to do this
    I18n.locale = in_admin? ? :en : I18n.default_locale
  end

  def in_admin?
    params[:controller].include?('admin/')
  end
end
