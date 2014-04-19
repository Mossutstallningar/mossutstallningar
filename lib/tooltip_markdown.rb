class TooltipMarkdown < Redcarpet::Render::HTML
  def initialize(*args)
    @resource = args[0][:resource]
    super
  end

  def preprocess(content)
    content = content_with_images(content)

    content
  end

  private

  def content_with_images(content)
    # match [image:id]
    content.gsub(/\[image:(.*)\]/) do
      id = "#{$1}".to_i

      if id > 0
        image = Image.find_by_id id

        if image.present?
          %Q|<img src="#{image.small}" alt="#{image.alt_text}" class="tooltip-image">|
        end
      end
    end
  end
end
