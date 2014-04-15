module ApplicationHelper
  def translate_link
    "http://www.microsofttranslator.com/bv.aspx?from=&to=en&a=#{root_url}"
  end

  def markdown(content, resource = nil)
    markdown = Redcarpet::Markdown.new CustomMarkdown.new(resource: resource)
    markdown.render(content).html_safe
  end
end
