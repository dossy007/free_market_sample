class CardsController < ApplicationController
  require "payjp"

  def new
    @item = Item.find(params[:item_id])
    card = Card.where(user_id: current_user.id)
  end

  def create
    if current_user.card.present?  #既に登録されていたら、削除
      card = Card.where(user_id: current_user.id).first
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end

    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: new
    else
      customer = Payjp::Customer.create(
      description: 'テスト',
      email: current_user.email,
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id,customer_id: customer.id, card_id: customer.default_card)
      @card.save
      redirect_to action: "new"
    end
  end

  def pay
  end
end
