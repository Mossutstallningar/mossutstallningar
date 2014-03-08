ActiveAdmin.register Project do
  actions :index, :update, :edit, :new, :create, :destroy
  menu priority: 1

  form html: { enctype: 'multipart/form-data' } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Project details' do
      f.input :title
      f.input :body
      f.has_many :images do |image|
        image.inputs 'Image' do
          image.input :description
          image.input :credit
          image.input :position
          image.input :attachment, as: :file, hint: image.template.image_tag(image.object.attachment.url(:small)), required: true
          image.input :_destroy, as: :boolean, required: false, label: 'Remove'
        end
      end
    end
    f.actions
  end

  index download_links: false do
    selectable_column
    column :id
    column :title
    actions
  end

  # Fix for broken projects index. hopefully fixed in future versions of Active
  # Admin. Note that ordering columns are not working with this fix.
  collection_action :index, method: :get do
    scope = Project.scoped
    @collection = scope.page params[:page]
  end

  controller do
    def permitted_params
      params.permit project: [
        :title,
        :body,
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
