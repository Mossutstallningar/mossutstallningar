module ApplicationHelper
  def translate_link
    "http://translate.google.com/translate?js=n&sl=auto&tl=destination_language&u=#{root_url}"
  end

  def markdown(content, resource = nil)
    markdown = Redcarpet::Markdown.new CustomMarkdown.new(resource: resource)
    markdown.render(content).html_safe
  end
end
