class CreatePageCategories < ActiveRecord::Migration
  def change
    create_table :page_categories do |t|
      t.string :name
    end
  end
end
