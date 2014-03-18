class AddSlugsToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :slug, :string
    add_index :pages, :slug, unique: true
  end

  def self.down
    remove_column :pages, :slug
    remove_index :pages, :slug
  end
end
