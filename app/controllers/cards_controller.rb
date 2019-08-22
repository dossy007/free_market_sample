class CardsController < ApplicationController
  before_action :redirect_flash, only: [:pay]
  require "payjp"

  def new
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    @item = Item.find(params[:item_id])
    card = Card.where(user_id: current_user.id).first
    if card != nil
      customer = Payjp::Customer.retrieve(card.customer_id)
      @card_information = customer.cards.retrieve(card.card_id)
    end
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
      redirect_to action: new,flash: {alert: "payjpに不具合"}
    else
      customer = Payjp::Customer.create(
      description: 'テスト',
      email: current_user.email,
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id,customer_id: customer.id, card_id: customer.default_card)
      @card.save
      redirect_to action: new
    end
  end

  def pay
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = current_user.card.customer_id
      Payjp::Charge.create(
        amount: params[:price],
        customer: customer,
        currency: 'jpy')
      buy = Buy.create(buy_params)
      buy.save
      redirect_to root_path
  end

  private
  def buy_params
    params.permit(:item_id).merge(user_id: current_user.id)
  end

  def redirect_flash
    #自分のものは買えない&不正防止&カード登録
    item = Item.find(params[:item_id])
    if item.price != params[:price].to_i || current_user.id == item.sell.first.user_id || item.buy.present?
      redirect_to root_path,flash: {alert: "不正もしくは売り切れもしくは自分で買おうとしてまへんか??"}
    elsif current_user.card.blank?
      redirect_to new_item_card_path, flash: {alert: "カードを登録してください"}
    end
  end
end
