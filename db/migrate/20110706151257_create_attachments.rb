class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.belongs_to :post
      t.string :name
      t.string :attachment

      t.timestamps
    end
    add_index :attachments, :post_id
  end
end
