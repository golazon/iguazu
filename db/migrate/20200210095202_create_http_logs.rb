class CreateHttpLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :http_logs do |t|
      t.string :url, null: false
      t.datetime :last_modified
      t.datetime :expires
      t.timestamps
    end

    add_index :http_logs, :url, unique: true
  end
end
