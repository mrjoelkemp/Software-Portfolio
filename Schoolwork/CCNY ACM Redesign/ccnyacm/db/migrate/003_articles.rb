class Articles < ActiveRecord::Migration
  def self.up
    create_table :articles, :force => true do |table|
	table.column :title,  :string, :limit=>120
	table.column :author, :string, :limit=>80
	table.column :date,   :date
	table.column :body,   :text
	table.column :filename, :string
	table.column :filetype, :string
	table.column :filesize, :string
    table.column :image_data,  :longblob
    end
  end

  def self.down
    drop_table :articles
  end
end

