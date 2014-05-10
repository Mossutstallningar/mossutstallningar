module ApplicationHelper
  def translate_link
    "http://www.microsofttranslator.com/bv.aspx?from=&to=en&a=#{root_url}"
  end

  def markdown(content)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
    markdown.render(content).html_safe
  end

  def page_markdown(content, resource = nil)
    page_markdown = Redcarpet::Markdown.new PageMarkdown.new(resource: resource)
    page_markdown.render(content).html_safe
  end

  def tooltip_markdown(content, resource = nil)
    tooltip_markdown = Redcarpet::Markdown.new TooltipMarkdown.new(resource: resource)
    tooltip_markdown.render(content).html_safe
  end
end
