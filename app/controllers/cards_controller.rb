class CardsController < ApplicationController
  before_action :redirect_flash, only: [:pay]
  before_action :authenticate_user!
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
      redirect_to new_item_card_path, alert: "payjp-tokenが見つかりません"
    else
      customer = Payjp::Customer.create(
      description: 'テスト',
      email: current_user.email,
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      #customer.newが使えないため
        card = Card.create(user_id: current_user.id,customer_id: customer.id, card_id: customer.default_card)
        redirect_to new_item_card_path

      end
      rescue => e
      redirect_to new_item_card_path, alert: 'カードの作成に失敗しました'
  end

  def pay
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = current_user.card.customer_id
      Payjp::Charge.create(
        amount: params[:price],
        customer: customer,
        currency: 'jpy')
      buy = Buy.new(buy_params)
      if buy.save
        redirect_to root_path
      else
        redirect_to new_item_card_path, alert: "#{buy.errors.full_messages}"
      end
      rescue => e
        redirect_to new_item_card_path, alert: "購入に失敗しました"
  end

  private
  def buy_params
    params.permit(:item_id).merge(user_id: current_user.id)
  end

  def redirect_flash
    #自分のものは買えない&不正防止&カード登録
    item = Item.find(params[:item_id])
    if item.price != params[:price].to_i || current_user.id == item.sell.user_id || item.buy.present?
      redirect_to root_path, alert: "不正もしくは売り切れもしくは自分で買おうとしてまへんか??"
    elsif current_user.card.blank?
      redirect_to new_item_card_path, alert: "カードを登録してください"
    end
  end
end
