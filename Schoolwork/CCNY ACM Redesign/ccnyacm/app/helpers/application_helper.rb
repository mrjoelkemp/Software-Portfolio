# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
		
	def hide_div_if(condition, attributes = {}, &block)
		if condition
		  attributes["style"] = "display: none"
		end
		content_tag("div", attributes, &block)
	end
	
	def show_div_if(condition, attributes = {}, &block)
		if !condition
		  attributes["style"] = "display: none"
		end
		content_tag("div", attributes, &block)
	end
	
	
	
end
