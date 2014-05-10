class SiteSettings
  def initialize(settings)
    @settings = settings
  end

  def logo_text
    get_value 'logo_text'
  end

  private

  def get_value(key)
    s = @settings.detect { |k| k['key'] == key }
    s.value
  end
end
