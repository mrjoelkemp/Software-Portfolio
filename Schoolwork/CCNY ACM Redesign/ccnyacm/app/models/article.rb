class Article < ActiveRecord::Base
	validates_presence_of :date
	validates_presence_of :body
	validates_presence_of :image_data
end