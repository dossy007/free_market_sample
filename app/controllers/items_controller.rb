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
      if item_params[:images_attributes] == nil
        redirect_to new_item_path, flash: {alert: "image抜けとるんと違うか?"}
      else
        sell = Sell.new(deal_params)
        if sell.save
          redirect_to root_path
        else
          redirect_to new_item_path,flash: {notice: "#{sell.errors.full_messages}"}
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

  def deal_params
    {user_id: current_user.id,item_id: @item.id}
  end

  def value_params
    params[:value_id].to_i
  end
  def middle_params
    params[:middle_id].to_i
  end
end
