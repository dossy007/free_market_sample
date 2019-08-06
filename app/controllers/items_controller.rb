class ItemsController < ApplicationController
	before_action :authenticate_user!,except: [:index]

  def index
    @items = Item.limit(8)
  end

  def new
  	@item = Item.new
    @item.images.build
    @categories = Category.new
    @topcategories = Category.all.order("id ASC").limit(13)
  end

  def show
  	@item = Item.find(params[:id])
  end

  def edit
  	@item = Item.find(params[:id])
  end

  def create
  	@item = Item.new(item_params)
    @item.save
    redirect_to root_path
  end


private
  def item_params
		params.require(:item).permit(:text, :name, :price, images_attributes: [:image])
  end
end
