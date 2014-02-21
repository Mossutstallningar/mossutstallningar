ActiveAdmin.register Project do
  actions :index, :update, :edit, :new, :create, :destroy
  menu priority: 1

  form html: { enctype: "multipart/form-data" } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Film Details" do
      f.input :title
      f.input :body
    end
    f.actions
  end

  index do
    selectable_column
    column :id
    column :title
    actions
  end

  controller do
    def permitted_params
      params.permit project: [
        :title,
        :body
      ]
    end
  end
end
