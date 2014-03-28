ActiveAdmin.register Product do
  actions :index, :update, :edit, :new, :create, :destroy
  menu priority: 3

  form html: { enctype: 'multipart/form-data' } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Product details' do
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
    column 'Link' do |product|
      link_to product.title, product_sv_path(product)
    end

    actions
  end

  controller do
    def update
      old_id = params[:id]
      new_id_candidate = params[:product][:title].parameterize

      update! do |format|
        if old_id == new_id_candidate
          format.html { redirect_to edit_admin_product_path params[:id] }
        else
          format.html { redirect_to admin_products_path }
        end
      end
    end

    def find_resource
      scoped_collection.friendly.find(params[:id])
    end

    def permitted_params
      params.permit product: [
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
