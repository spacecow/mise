class CreateArticles < ActiveRecord::Migration

  def up
    create_table :articles do |t|
      t.string :title, null:false
      t.timestamps null:false
    end
    execute "alter table articles add constraint title_cannot_be_blank check (char_length(title) <> 0)"
  end

  def down
    drop_table :articles
  end

end
