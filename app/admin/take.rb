ActiveAdmin.register Take do
  actions :index, :update, :edit, :new, :create, :destroy
  menu priority: 4

  form html: { enctype: 'multipart/form-data' } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Take details' do
      f.input :title
      f.input :body
      f.input :published

      images f
      attachments f
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
      new_id_candidate = params[:take][:title].parameterize

      update! do |format|
        if old_id == new_id_candidate
          format.html { redirect_to edit_admin_take_path params[:id] }
        else
          format.html { redirect_to admin_takes_path }
        end
      end
    end

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
