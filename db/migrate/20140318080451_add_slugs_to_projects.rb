class AddSlugsToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :slug, :string
    add_index :projects, :slug, unique: true
  end

  def self.down
    remove_column :projects, :slug
    remove_index :projects, :slug
  end
end
