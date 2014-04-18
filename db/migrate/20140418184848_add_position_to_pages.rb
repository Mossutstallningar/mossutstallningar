class AddPositionToPages < ActiveRecord::Migration
  def change
    add_column :pages, :position, :integer, default: 0, null: false
  end
end
