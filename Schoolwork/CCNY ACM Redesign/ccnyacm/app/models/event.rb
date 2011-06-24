class Event < ActiveRecord::Base
	validates_presence_of :title
	validates_presence_of :room
	validates_presence_of :date
	validates_presence_of :time
	validates_presence_of :abstract
	validates_presence_of :image_data	
end
