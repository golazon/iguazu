class AddEtagToHttpLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :http_logs, :etag, :string
  end
end
