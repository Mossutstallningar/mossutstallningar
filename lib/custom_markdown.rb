class CustomMarkdown < Redcarpet::Render::HTML
  def initialize(*args)
    @resource = args[0][:resource]
    super
  end

  def preprocess(content)
    content = content_with_image_chaos(content) if has_resource?
    content = content_with_vimeo(content)
    content = content_with_caption_images(content)

    content
  end

  private

  def has_resource?
    @resource.present? && @resource.images.present?
  end

  def content_with_vimeo(content)
    # match [vimeo:12345]
    content.gsub(/\[vimeo:(.*)\]/) do
      iframe("//player.vimeo.com/video/#{$1}?title=0&amp;byline=0&amp;portrait=0&amp;color=673ff9")
    end
  end

  def content_with_image_chaos(content)
    # match [images]
    content.gsub(/(\[images\])/) do
      html = ''
      html << '<div class="image-chaos">'
      html << '<ul class="image-chaos-items">'

      @resource.images.each_with_index do |image, i|
        html << %Q|<li class="image-chaos-item" data-image-index="#{i}" data-image-large="#{image.large}" data-image-credit="#{image.credit}">|
        html << %Q|<img src="#{image.small}" alt="#{image.description}" class="image-chaos-image">|
        html << '</li>'
      end

      html << '</ul>'
      html << '</div>'
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

  def iframe(src)
    html = ''
    html << '<div class="video-wrapper">'
    html << %Q|<iframe src="#{src}" class="video-iframe" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>|
    html << '</div>'

    html
  end
end
