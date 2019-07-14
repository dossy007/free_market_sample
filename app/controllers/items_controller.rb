class ItemsController < ApplicationController
	before_action :authenticate_user!,only: [:new,:create]

  def index
    @items = Item.limit(10)
  end

  def new
  	@item = Item.new
  end

  def create
  	@item = Item.create
  end


  private
  def param
  end
end
