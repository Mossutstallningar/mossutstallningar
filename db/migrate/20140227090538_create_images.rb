class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :description
      t.string :credit
      t.integer :position, default: 0, null: false
      t.integer :project_id
    end
  end
end
