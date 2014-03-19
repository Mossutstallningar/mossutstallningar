class AddTimestampsToPageCategories < ActiveRecord::Migration
  def change
    add_column :page_categories, :created_at, :datetime
    add_column :page_categories, :updated_at, :datetime
  end
end
