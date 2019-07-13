class ItemsController < ApplicationController
  def index
  	@items = Item.limit(10)
  end
end
