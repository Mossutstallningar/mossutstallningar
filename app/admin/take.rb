ActiveAdmin.register Take do
  config.breadcrumb = false
  actions :index, :update, :edit, :new, :create, :destroy
  menu priority: 3

  form html: { enctype: 'multipart/form-data' } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Take details' do
      f.input :title
      f.input :body
      f.input :published
      f.has_many :images do |image|
        image.inputs do
          image.input :description
          image.input :credit
          image.input :position
          image.input :attachment, as: :file, hint: (image.object.new_record? ? nil : image.template.image_tag(image.object.attachment.url(:small))), required: true
          unless image.object.new_record?
            image.input :large, label: 'URL', input_html: { disabled: true }
            image.input :_destroy, as: :boolean, required: false, label: 'Remove'
          end
        end
      end
    end
    f.actions
  end

  index do
    selectable_column
    column :id
    column :title
    column :published
    actions
  end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end

    def permitted_params
      params.permit take: [
        :title,
        :body,
        :published,
        images_attributes: [
          :id,
          :description,
          :credit,
          :position,
          :attachment,
          :_destroy
        ]
      ]
    end
  end
end
