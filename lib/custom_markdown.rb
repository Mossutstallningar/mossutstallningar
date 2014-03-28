class CustomMarkdown < Redcarpet::Render::HTML
  def initialize(*args)
    @resource = args[0][:resource]
    super
  end

  def preprocess(content)
    content = content_with_image_chaos(content) if has_resource?
    content = content_with_attachment(content)
    content = content_with_vimeo(content)
    content = content_with_youtube(content)
    content = content_with_caption_images(content)

    content
  end

  private

  def has_resource?
    @resource.present? && @resource.images.present?
  end

  def content_with_vimeo(content)
    # match [vimeo:video_id]
    content.gsub(/\[vimeo:(.*)\]/) do
      iframe("//player.vimeo.com/video/#{$1}?title=0&amp;byline=0&amp;portrait=0&amp;color=673ff9")
    end
  end

  def content_with_youtube(content)
    # match [youtube:video_id]
    content.gsub(/\[youtube:(.*)\]/) do
      iframe("//www.youtube.com/embed/#{$1}?rel=0")
    end
  end

  def content_with_image_chaos(content)
    # match [images]
    content.gsub(/(\[images\])/) do
      html = ''
      html << '<div class="image-chaos">'
      html << '<ul class="image-chaos-items">'

      @resource.images.order_by_position.each_with_index do |image, i|
        html << %Q|<li class="image-chaos-item" data-image-index="#{i}" data-image-large="#{image.large}" data-image-credit="#{image.credit}">|
        html << %Q|<img src="#{image.small}" alt="#{image.description}" class="image-chaos-image" crossorigin="anonymous">|
        html << '</li>'
      end

      html << '</ul>'
      html << '</div>'
    end
  end

  def content_with_caption_images(content)
    # match [image:id]
    content.gsub(/\[image:(.*)\]/) do
      id = "#{$1}".to_i

      if id > 0
        image = Image.find_by_id id

        if image.present?
          html = ''
          html << '<span class="image-with-caption">'
          html << %Q|<img src="#{image.large}" alt="#{image.description}" class="image-with-caption-image" crossorigin="anonymous">|
          html << %Q|<span class="image-with-caption-caption">#{image.credit}</span>|
          html << '</span>'

          html
        end
      end
    end
  end

  def content_with_attachment(content)
    # match [attachment:id]
    content.gsub(/\[attachment:(.*)\]/) do
      id = "#{$1}".to_i
      if id > 0
        attachment = Attachment.find_by_id id

        if attachment.present?
          %Q|<a href="#{attachment.url}" download>#{attachment.name}</a>|
        end
      end
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
