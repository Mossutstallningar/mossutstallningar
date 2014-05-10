ActiveAdmin.register Setting do
  actions :index, :update, :edit
  menu priority: 7

  form do |f|
   f.inputs 'Setting Details' do
      f.input :key, input_html: { disabled: true }
      f.input :value
    end
    f.actions
  end

  index do
    column :id
    column :key
    column :value
    actions
  end

  controller do
    def permitted_params
      params.permit setting: [:value]
    end
  end
end
