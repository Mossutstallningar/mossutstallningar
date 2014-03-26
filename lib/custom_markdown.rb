class CustomMarkdown < Redcarpet::Render::HTML
  def initialize(*args)
    @resource = args[0][:resource]
    super
  end

  def preprocess(content)
    content = content_with_image_chaos(content) if has_resource?
    content = content_with_caption_images(content)

    content
  end

  private

  def has_resource?
    @resource.present? && @resource.images.present?
  end

  def content_with_image_chaos(content)
    # match [images]
    content.gsub(/(\[images\])/) do
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

  def content_with_caption_images(content)
    # match [image:src|alt|caption]
    content.gsub(/\[image:(.*)\|(.*)\|(.*)\]/) do
      html = ''
      html << '<span class="image-with-caption">'
      html << %Q|<img src="#{$1}" alt="#{$2}" class="image-with-caption-image">|
      html << %Q|<span class="image-with-caption-caption">#{$3}</span>|
      html << '</span>'

      html
    end
  end
end
