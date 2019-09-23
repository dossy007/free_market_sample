class CategoryController < ApplicationController
  def index
    @topcategories = Category.all.order("id ASC").limit(13)
  end
end
