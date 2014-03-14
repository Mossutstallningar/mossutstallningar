class AddPageCategoryToPage < ActiveRecord::Migration
  def change
    add_column :pages, :page_category_id, :integer
  end
end
