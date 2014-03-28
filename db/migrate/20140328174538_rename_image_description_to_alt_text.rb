class RenameImageDescriptionToAltText < ActiveRecord::Migration
  def change
    rename_column :images, :description, :alt_text
  end
end
