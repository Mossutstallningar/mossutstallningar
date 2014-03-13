ActiveAdmin.register Page do
  actions :index, :update, :edit, :new, :create, :destroy
  menu priority: 2

  index download_links: false do
    selectable_column
    column :id
    column :title
    actions
  end

  controller do
    def permitted_params
      params.permit page: [
        :title,
        :body
      ]
    end
  end
end
