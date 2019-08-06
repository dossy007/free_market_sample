class Category < ApplicationRecord
	has_closure_tree

	def inspect
		"[#{name}]"
	end
end
