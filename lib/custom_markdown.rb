class CustomMarkdown < Redcarpet::Render::HTML
  def initialize(*args)
    @resource = args[0][:resource]

    super
  end

  def preprocess(full_document)
    if @resource.present? && @resource.images.present?
      # match [images]
      full_document.gsub!(/(\[images\])/) do
        html = ''
        html << '<ul class="image-chaos">'

        @resource.images.each do |image|
          html << '<li class="image-chaos-item">'
          html << %Q|<img src="#{image.small}" alt="#{image.description}" class="image-chaos-image">|
          html << '</li>'
        end

        html << '</ul>'
      end
    end

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
