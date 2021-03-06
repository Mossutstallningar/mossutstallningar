# restart server after editing this file
module ActiveAdmin::ViewsHelper
  def images(f)
    f.has_many :images do |image|
      unless image.object.new_record?
        image.input :id, input_html: { disabled: true }
      end
      image.input :alt_text
      image.input :credit
      image.input :position
      image.input :for_gallery
      image.input :attachment, as: :file, hint: (image.object.new_record? ? nil : image.template.image_tag(image.object.attachment.url(:small))), required: true
      unless image.object.new_record?
        image.input :_destroy, as: :boolean, required: false, label: 'Remove'
      end
    end
  end

  def attachments(f)
    f.has_many :attachments do |attachment|
      unless attachment.object.new_record?
        attachment.input :id, input_html: { disabled: true }
      end
      attachment.input :name
      attachment.input :attachment, label: 'File (PDF or Zip)', as: :file, required: true
      unless attachment.object.new_record?
        attachment.input :_destroy, as: :boolean, required: false, label: 'Remove'
      end
    end
  end
end
