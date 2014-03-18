ActiveAdmin.register Page do
  actions :index, :update, :edit, :new, :create, :destroy
  menu priority: 2

  index do
    selectable_column
    column :id
    column :title
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Page details' do
      f.input :title
      f.input :body
      f.input :page_category_id, as: :select, collection: PageCategory.all.map {|f| [f.name, f.id]}
    end
    f.actions
  end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end

    def permitted_params
      params.permit page: [
        :title,
        :body,
        :page_category_id
      ]
    end
  end
end
