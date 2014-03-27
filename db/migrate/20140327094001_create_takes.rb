class CreateTakes < ActiveRecord::Migration
  def change
    create_table :takes do |t|
      t.string :title
      t.text :body
      t.text :slug
      t.boolean :published, default: false

      t.timestamps
    end
  end
end
