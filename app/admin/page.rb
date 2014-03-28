ActiveAdmin.register Page do
  actions :index, :update, :edit, :new, :create, :destroy
  menu priority: 2

  index do
    selectable_column
    column :id
    column :title
    column :published
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Page details' do
      f.input :title
      f.input :body
      f.input :page_category_id, as: :select, collection: PageCategory.all.map {|f| [f.name, f.id]}
      f.input :published

      images f
      attachments f
    end
    f.actions
  end

  controller do
    def update
      old_id = params[:id]
      new_id_candidate = params[:page][:title].parameterize

      update! do |format|
        if old_id == new_id_candidate
          format.html { redirect_to edit_admin_page_path params[:id] }
        else
          format.html { redirect_to admin_pages_path }
        end
      end
    end

    def find_resource
      scoped_collection.friendly.find(params[:id])
    end

    def permitted_params
      params.permit page: [
        :title,
        :body,
        :published,
        :page_category_id,
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
