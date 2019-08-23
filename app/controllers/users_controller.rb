class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def sell_item
  	@sell_items = Item.where(id: current_user.sell.ids).limit(8)
  end
end
