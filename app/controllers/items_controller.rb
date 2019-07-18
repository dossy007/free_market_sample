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
  	item = Item.new(item_params)
  	item.save
  end


  private
  def item_params
		params.require(:item).permit(:text, :name, :price, images_attributes: [:id,:image])
  end
end
