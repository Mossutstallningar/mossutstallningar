ActiveAdmin.register Project do
  actions :index, :update, :edit, :new, :create, :destroy
  menu priority: 1

  form html: { enctype: 'multipart/form-data' } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Project details' do
      f.input :title
      f.input :body
      f.input :published
      f.has_many :images do |image|
        image.inputs do
          unless image.object.new_record?
            image.input :id, input_html: { disabled: true }
          end
          image.input :description
          image.input :credit
          image.input :position
          image.input :attachment, as: :file, hint: (image.object.new_record? ? nil : image.template.image_tag(image.object.attachment.url(:small))), required: true
          unless image.object.new_record?
            image.input :_destroy, as: :boolean, required: false, label: 'Remove'
          end
        end
      end
      f.has_many :attachments do |attachment|
        attachment.inputs do
          unless attachment.object.new_record?
            attachment.input :id, input_html: { disabled: true }
          end
          attachment.input :name
          attachment.input :attachment, label: 'File (PDF or Zip)', as: :file, required: true, required: true
          unless attachment.object.new_record?
            attachment.input :_destroy, as: :boolean, required: false, label: 'Remove'
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
    def update
      old_id = params[:id]
      new_id_candidate = params[:project][:title].parameterize

      update! do |format|
        if old_id == new_id_candidate
          format.html { redirect_to edit_admin_project_path params[:id] }
        else
          format.html { redirect_to admin_projects_path }
        end
      end
    end

    def find_resource
      scoped_collection.friendly.find(params[:id])
    end

    def permitted_params
      params.permit project: [
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
        ],
        attachments_attributes: [
          :id,
          :name,
          :attachment,
          :_destroy
        ]
      ]
    end
  end
end
