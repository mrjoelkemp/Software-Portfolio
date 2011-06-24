class Messages < ActiveRecord::Migration
  def self.up
    create_table :messages do |table|
      table.column :sent_on, :date
      table.column :time, :time
      table.column :from, :string #not null
      table.column :to, :string #
      table.column :subject, :string
      table.column :body, :text
      table.column :isRead, :bool
      table.column :user_id, :integer
    end
  end

  def self.down
    drop_table :messages
  end
end
