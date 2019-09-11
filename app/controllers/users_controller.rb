class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def sell_item
    @sell_items = Item.where(id: sell_item_ids).limit(8)
  end

  private
  def sell_item_ids
  	sell_diction = []
  	current_user.sell.each do |se|
  		sell_diction << se.item_id
  	end
  	return sell_diction
  end
end
