class CreateMailItems < ActiveRecord::Migration
  def change
    create_table :mail_items do |t|
      t.string :name
      t.string :watermark
      t.string :date
      t.string :item_id
      t.string :subject
      t.text :body
      t.string :sender
      t.string :from
      t.text :is_read

      t.timestamps
    end
  end
end
