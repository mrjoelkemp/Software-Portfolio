class Users < ActiveRecord::Migration
  def self.up
    create_table :users do |table|
      table.column :userName, :string # not null
      table.column :password, :string #
      table.column :firstName, :string #
      table.column :lastName, :string #
      table.column :emailAddress, :string
      table.column :ccnyEmailAddress, :string 
      table.column :phone, :string
      table.column :websiteUrl, :string
	  table.column :filename, :string
	  table.column :filesize, :string
	  table.column :filetype, :string
      table.column :picture_data, :longblob
      table.column :interests, :text
	  table.column :isAdmin, :bool
      table.column :approved, :bool
      table.column :invisible, :bool
    end
  end

  def self.down
    drop_table :users
  end
end
