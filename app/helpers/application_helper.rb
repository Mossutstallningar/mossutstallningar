module ApplicationHelper
  def translate_link
    "http://translate.google.com/translate?js=n&sl=auto&tl=destination_language&u=#{root_url}"
  end

  def markdown(content)
    markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML, autolink: true, :space_after_headers => false
    markdown.render(content).html_safe
  end
end
