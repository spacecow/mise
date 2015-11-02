class CreateImages < ActiveRecord::Migration

  def up
    create_table :images do |t|
      t.integer :gallery_id, null:false
      t.string :content
      t.timestamps null:false
    end
    add_foreign_key :images, :galleries
  end

  def down
    drop_table :images
  end

end
