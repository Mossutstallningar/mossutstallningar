class AddGalleryOptionToImages < ActiveRecord::Migration
  def change
    add_column :images, :for_gallery, :boolean, default: false
  end
end
