class CategoryController < ApplicationController
  def index
    @topcategories = Category.order("id ASC").limit(13)
  end
end
