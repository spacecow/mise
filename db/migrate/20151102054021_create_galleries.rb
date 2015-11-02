class CreateGalleries < ActiveRecord::Migration

  def up
    create_table :galleries do |t|
      t.integer :article_id, null:false
      t.timestamps null:false
    end
    add_foreign_key :galleries, :articles
  end

  def down
    drop_table :galleries
  end

end
