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

  # ajax用
  def search
    if params[:value_id]
    @m_category = Category.find(value_params).children
  else
    @s_category = Category.find(middle_params).children
  end
    # binding.pry
  end


private
  def item_params
		params.require(:item).permit(:text, :name, :price, images_attributes: [:image])
  end

  def value_params
    params[:value_id].to_i
  end
end
