class Events < ActiveRecord::Migration
  def self.up
    create_table :events, :force => true do |table|
	table.column :title,  :string, :limit=>80
	table.column :room,  :string, :limit=>20
	table.column :location, :string, :limit=>60
	table.column :date,  :date
	table.column :time,  :time
	table.column :speaker, :string, :limit=>60
	table.column :abstract, :text
	table.column :bio,   :text
	table.column :full_text, :text
	table.column :filename, :string
	table.column :filesize, :string
	table.column :filetype, :string
	table.column :image_data,  :longblob
    end
  end

  def self.down
    drop_table :events
  end
end

