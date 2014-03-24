class CustomMarkdown < Redcarpet::Render::HTML
  def preprocess(full_document)
    full_document.gsub(/\[image:(.*)\|(.*)\|(.*)\]/) do
      html = ''
      html << %-<img src="#{$1}" alt="#{$2}">-
      html << "<span>#{$3}</span>"

      html
    end
  end
end
