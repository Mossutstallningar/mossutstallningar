ActiveAdmin.register PageCategory do
  config.breadcrumb = false
  actions :index, :update, :edit, :new, :create, :destroy
  menu priority: 4

  index do
    selectable_column
    column :id
    column :name
    actions
  end

  controller do
    def permitted_params
      params.permit page_category: [
        :name
      ]
    end
  end
end
