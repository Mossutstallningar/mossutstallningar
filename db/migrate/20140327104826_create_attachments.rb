class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :name
      t.attachment :attachment
      t.integer :attachable_id
      t.string :attachable_type

      t.timestamps
    end
  end
end
