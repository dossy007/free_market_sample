# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  2.5.1
* System dependencies
  mercariの模範サイトを作成
  front側はすでにほぼ作成済みの物を使用。
  jsやrailsを使用。
  
  
  
* Configuration

* Database creation

## User_table
|Column|Type|Option|
|------|----|------|
|nick_name|string||
|email|string| null: false,unique: true, default: ""|
|encrypted_password|string|null: false, default: ""|
|last_name|string||
|first_name|string||
|last_name(kana)|string||
|first_name(kana)|string||
|birth_year|integer||
|birth_month|integer||
|birth_day|integer||
|credit_id|integer||
|postal_code|integer||
|prefecture|integer||
|city_name|string||
|house_number|string||
|building_name|string||
|user_evaluation_id|integer|
|points|string||
|total_sell_money|string||


## Assosiation
has_one: profile
has_many :item_comments
has_one :user_evaluation
<!-- 以下はitemとのアソシエーション -->
has_many :deals_of _seller, :class_name=> 'Deal', :foreign_key=>'seller_id'
has_many :deals_of_buyer, :class_name=> 'Deal', :foreign_key=>'buyer_id'
has_many :items_of_seller, :through=> :deals_of_seller, :source=>'item'
has_many :items_of_buyer, :through=> :deals_of_buyer, :source=> 'item'

## User_evaluation
|Column|Type|Option|
|------|----|------|
|good|integer||
|normal|integer||
|bad|integer||

## Association
belogs_to :user

## Deal
|Column|Type|Option|
|------|----|------|
|item|references|foreign_key: true|
|seller|references|foreign_key: true|
|buyer|references|foreign_key: true|

## Association
belongs_to :seller, :class_name=>'User'
belongs_to :buyer, :class_name=>'Item'
belongs_to :item
has_many :items_of_seller, :through => :deals_of_seller


## Item
|Column|Type|Option|
|------|----|------|
|name|string||
|size|integer||
|brand|string||
|shopping_status|integer|
|send_burden|integer|
|shopping_method|integer|
|prefecture|integer||
|delivery_date|integer||
|price|integer||
|text|text||
|comment|references|foreign_key :true|
|good_function|integer||
|category_id|references|foreign_key: true|
## Association
has_many :item_comments
has_many :item_imgs
has_one :category
<!-- 以下はuserとのアソシエーション-->
has_many :deals
has_many :sellers, :through=> :deals
has_many :buyers, :through=> :deals

## Item_comment
|Column|Type|Option|
|------|----|------|
|text|text||

## Association
belongs_to :user
belongs_to :item


## Item_img
|Column|Type|Option|
|------|----|------|
|img_path|string||
|item_id|integer||

## Association
belongs_to :item

## Categoty_table

|Column|Type|Option|
|------|----|------|
|name|string||

## Association
belongs_to :item
has_one :category_tree_table

## Category_tree_table
|Column|Type|Option|
|------|----|------|
|category_tree_id|integer|
|ancestor_category_id|integer|
|descendent_category_id|integer|

## Association
belongs_to :category_tree_table
