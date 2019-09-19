class ItemsController < ApplicationController
  before_action :authenticate_user!,except: [:index]
  before_action :get_category, only: [:edit,:show]
  before_action :prepared_update, only: [:update]
  before_action :set_category,only: [:category]
  before_action :set_search,only: [:seeking]
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
    # binding.pry
    @topcategories = Category.all.order("id ASC").limit(13)
  end

  def seeking
    @items = @q.result
    # binding.pry
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

  def set_search #検索用
    #ここでparams[:q][:category_id_matches_any]の中身を帰る配列にする
    o = params[:q][:category_id_matches_any]
    m = params[:q][:mcategory_id]
    g = params[:q][:scategory_id]
    # num = Category.find(o).parent
    # binding.pry
    if o.length != 0 # trueならoに値が入っている状態
    # binding.pry
      # oがある時
      if g == nil || g == "" #grandchildを探す
        #true gがない時
        # binding.pry
        # binding.pry
        #false ない時mを探す
        if m.length != 0
          #mがある時
          o = Category.find(m).children.ids
        else
          #mがない時 ""の時
          o = find_child_grand(o)
          # binding.pry
        end
      else
       o = g
      end
      # if Category.where(o).parent != nil
      #   #false
      #   o = find_child_grand(o)
      # else
      #   #true
      #   if Category.find(o).children != nil
      #     #false子
      #     # 子を全取得
      #     o = Category.find(o).children.ids
      #     # else
      #       #true孫
      #       # 何もしない
      #   end
      # end
    # binding.pry
    # false.categoryが何も選択されていない時は処理を飛ばす.何もしない
    end
    # binding.pry
    params[:q][:category_id_matches_any] = o
    @q = Item.ransack(params[:q])
  end

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

  def find_child_grand(num) #parentがnilのとき
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

  def prepared_update
    image = Image.where(item_id: params[:id].to_i)
    if image.length == 0
      redirect_to edit_item_path
    end
  end

  def delete_params
    params[:id].to_i
  end
end
