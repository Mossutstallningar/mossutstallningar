ActiveAdmin.register Project do
  actions :index, :update, :edit, :new, :create, :destroy
  menu priority: 1

  form html: { enctype: 'multipart/form-data' } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Project details' do
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
    column 'Link' do |project|
      link_to project.title, project_sv_path(project)
    end

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
          :for_gallery,
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
