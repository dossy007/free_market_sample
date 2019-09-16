class CategoriesController < ApplicationController
	before_action :set_category
	after_action :set_item
	def parent
	end

	def child
		 catego = Category.where(parent_id: params[:id])
    return catego.ids
	end

	def grandchild
	end


	private
	def set_category
		@category = Category.find(params[:id])
	end

	def set_item
		@items = Item.where(category_id: @category_id)
	end

	def parent_params
		@category_id = []
    @categories = Category.where(parent_id: params[:id])
    @categories.ids.each do |cate|
      Category.find(cate).children.ids.each do |e|
        @category_id << e
      end
    end
    return @category_id
	end


end
