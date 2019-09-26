class ItemsController < ApplicationController
  before_action :authenticate_user!,except: [:index,:show,:search_item,:seek_item,:search,:category]
  before_action :get_category, only: [:edit,:show]
  before_action :prepared_update, only: [:update]
  before_action :set_category,only: [:category]
  before_action :set_search,only: [:seek_item]
  before_action :item_keyword,only: [:search_item,:seek_item]

  def index
    @category = Category.find(2) #// MEMO: pickupcategoryをメンズに固定
    @category_ids = @category.leaves.ids
    @items = Item.where(category_id: @category_ids)
  end

  def new
    @item = Item.new
    @item.images.build
    @categories = Category.new
    @topcategories = Category.all.order("id ASC").limit(13)
  end

  def show
  end

  def edit
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
      if item_params[:images_attributes] == nil
        redirect_to new_item_path, alert: "image抜けとるんと違うか?"
      else
        @item = Item.new(item_params)
        @item.save
        sell = Sell.new(deal_params)
        if sell.save
          redirect_to root_path
        else
          redirect_to new_item_path, alert: "#{sell.errors.full_messages}"
        end
      end
      rescue => e
        redirect_to new_item_path, alert: "作成に失敗しました"
  end

  def destroy
    item = Item.find(delete_params)
    image = Image.where(item_id: delete_params)
    sell = Sell.where(item_id: delete_params)
    if image.destroy_all && sell.destroy_all && item.destroy
      redirect_to root_path,alert: "削除に成功しました"
    end
    rescue => e
      redirect_to item_path, alert: "削除に失敗しました"
  end

  # ajax用
  def search
    if params[:value_id]
      @m_category = Category.find(value_params).children
    else
      @s_category = Category.find(middle_params).children
    end
  end

  def search_item
    @q = Item.ransack(params[:q])
    @items = Item.where('name LIKE ? OR text LIKE ?',"%#{params[:keyword]}%","%#{params[:keyword]}%")
    @topcategories = Category.all.order("id ASC").limit(13)
  end

  def seek_item #ransack検索
    @items = @q.result
    @topcategories = Category.all.order("id ASC").limit(13)
    render "search_item"
  end

  def category
    case params[:categorize_id].to_i
    when 1 then
      @category_id = parent_category
    when 2 then
      @category_id = middle_category
    when 3 then
      @category_id = params[:id]
    end

    @items = Item.where(category_id: @category_id)
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

  def delete_params
    params[:id].to_i
  end

  def prepared_update
    image = Image.where(item_id: params[:id].to_i)
    if image.length == 0
      redirect_to edit_item_path
    end
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

  def parent_category
    @category_id = []
    @categories = Category.where(parent_id: params[:id])
    @categories.ids.each do |cate|
      Category.find(cate).children.ids.each do |e|
        @category_id << e
      end
    end
    return @category_id
  end

  def set_search
    base = params[:q][:category_id_matches_any]
    m = params[:q][:mcategory_id]
    g = params[:q][:scategory_id]
    if base.length != 0
      if g == nil || g == "" #grandchildを探す
        if m.length != 0
          #mがある時
          base = Category.find(m).children.ids
        else
          #mがない時
          base = find_child_grand(base)
        end
      else
        base = g
      end
    end
    params[:q][:category_id_matches_any] = base
    @q = Item.ransack(params[:q])
  end

  def find_child_grand(num)
    @category_id = []
    @categories = Category.where(parent_id: num)
    @categories.ids.each do |cate|
      Category.find(cate).children.ids.each do |e|
        @category_id << e
      end
    end
    return @category_id
  end

  def middle_category
    catego = Category.where(parent_id: params[:id])
    return catego.ids
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def item_keyword
    @keyword = params[:keyword]
  end
end
