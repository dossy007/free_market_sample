class ItemsController < ApplicationController
	before_action :authenticate_user!,only: [:new,:create]

  def index
    @items = Item.limit(8)
  end

  def new
  	@item = Item.new
    @item.images.build
  end

  def show
  	@item = Item.find(params[:id])
  end

  def edit
  	@item = Item.find(params[:id])
  end

  def create
  	@item = Item.new(item_params)
  	# respond_to do |format|
       @item.save
      	 #imagesを配列で受け取っているので、一枚一枚分けて保存
          # params[:images][:image].each do |image|
          #   @item.images.create(image: image,item_id: @item.id)
          # end
        redirect_to root_path
      # else
        # item_images.build
        # format.html{render action: 'new'}
      # end
    # end
  end


private
  def item_params
		params.require(:item).permit(:text, :name, :price, images_attributes: [:image])
  end
end
