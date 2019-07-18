class ItemsController < ApplicationController
	before_action :authenticate_user!,only: [:new,:create]

  def index
    @items = Item.limit(8)
  end

  def new
  	@item = Item.new
  	@item.images.build
  end

  def create
  	@item = Item.create
  end


  private
  def item_params
  	params.require(:item).permit(:text,images_attributes: [:image])
  end
end
