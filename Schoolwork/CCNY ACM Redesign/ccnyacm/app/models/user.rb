class User < ActiveRecord::Base
  validates_presence_of :userName
  validates_presence_of :password
  validates_presence_of :firstName
  validates_presence_of :lastName
  validates_presence_of :emailAddress
  
  has_many :messages, :order => "sent_on"
end
