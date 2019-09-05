class ItemsController < ApplicationController
  before_action :authenticate_user!,except: [:index]
  before_action :get_category, only: [:edit]
  before_action :prepared_update, only: [:update]

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
    @imgs = @item.images
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(update_params)
      redirect_to root_path
    else
      redirect_to edit_item_path, alert: "編集に失敗しました"
    end
  end

  def create
      @item = Item.new(item_params)
      if item_params[:images_attributes] == nil
        redirect_to new_item_path, alert: "image抜けとるんと違うか?"
      else
        @item.save
        sell = Sell.new(deal_params)
        if sell.save
          redirect_to root_path
        else
          redirect_to new_item_path, alert: "#{sell.errors.full_messages}"
        end
      end
      rescue => e
        redirect_to new_item_path, alert: "購入に失敗しました"
  end

  # ajax用
  def search
    if params[:value_id]
      @m_category = Category.find(value_params).children
    else
      @s_category = Category.find(middle_params).children
    end
  end


private
  def item_params
    params.require(:item).permit(:text, :name,:brand, :price,:delivery_date,:shopping_status,:send_burden,:category_id,:prefecture_id, images_attributes: [:image])
  end

  def update_params
    params.require(:item).permit(:text, :name,:brand, :price,:delivery_date,:shopping_status,:send_burden,:category_id,:prefecture_id)
  end

  def deal_params
    { user_id: current_user.id,item_id: @item.id}
  end

  def value_params
    params[:value_id].to_i
  end
  def middle_params
    params[:middle_id].to_i
  end

  def get_category
    @item = Item.find(params[:id])
    @lcate = Category.find(@item.category_id)
    @mcate = Category.find(@lcate.id).parent
    @topcate = Category.find(@mcate.id).parent
    @topcategories = Category.all.order("id ASC").limit(13)
    @mcategory = Category.find(@topcate.id).children
    @lcategory = Category.find(@mcate.id).children
  end

  def prepared_update
    image = Image.where(item_id: params[:id].to_i)
    if image.length == 0
      redirect_to edit_item_path
    end
  end
end
