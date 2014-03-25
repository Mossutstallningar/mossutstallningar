class AddImageableToImage < ActiveRecord::Migration
  def change
    add_column :images, :imageable_id, :integer
    add_column :images, :imageable_type, :string
    remove_column :images, :project_id
  end
end
