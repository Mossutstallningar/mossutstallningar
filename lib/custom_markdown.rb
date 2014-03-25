class CustomMarkdown < Redcarpet::Render::HTML
  def preprocess(full_document)
    # match [image:src|alt|caption]
    full_document.gsub(/\[image:(.*)\|(.*)\|(.*)\]/) do
      html = ''
      html << '<span class="image-with-caption">'
      html << %Q|<img src="#{$1}" alt="#{$2}" class="image-with-caption-image">|
      html << %Q|<span class="image-with-caption-caption">#{$3}</span>|
      html << '</span>'

      html
    end
  end
end
