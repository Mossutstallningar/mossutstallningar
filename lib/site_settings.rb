class SiteSettings
  def initialize(settings)
    @settings = settings
  end

  def logo_text
    get_value 'logo_text'
  end

  def buy_text
    get_value 'buy_text'
  end

  def giveaways_text
    get_value 'giveaways_text'
  end

  def translate_text
    get_value 'translate_text'
  end

  def search_text
    get_value 'search_text'
  end

  private

  def get_value(key)
    s = @settings.detect { |k| k['key'] == key }
    s.value if s.present?
  end
end
