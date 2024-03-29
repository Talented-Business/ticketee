module TicketsHelper
	def state_for(comment)
		content_tag(:div,:class=>"states") do
			if comment.state
				if comment.previous_state && comment.state != comment.previous_state
					html = "#{render comment.previous_state}&rarr; #{render comment.state}"
				else
					html = render(comment.state)
				end
				html.html_safe
			end
		end
	end
end
