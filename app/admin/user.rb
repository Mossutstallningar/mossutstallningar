ActiveAdmin.register User do
  index download_links: false

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column "" do |admin_user|
      if admin_user == current_user
        link_to("Edit", edit_admin_user_path(admin_user))
      end
    end
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    def permitted_params
      if (params[:id].to_i == current_user.id)
        params.permit user: [:email, :password, :password_confirmation]
      end
    end
  end
end
