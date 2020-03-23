class CreateFeed < ActiveRecord::Migration[6.0]
  def change
    create_table :feed do |t|
      t.string :type
      t.string :type_id
      t.jsonb :content
      t.datetime :published_at
      t.timestamps
    end

    add_index :feed, %w(type type_id), unique: true
  end
end
