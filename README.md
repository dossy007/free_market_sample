# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

数字はinteger
文字列型はstring
長い文字列はtext
indexをはる　＝　速度を早める
外部キー制約は、主キーと結びつけるために必ずvalueをnull以外にしてねというもの。
reference型は外部キーに制約を使う時に使用(制約つけるとindexがautoでつく)user_idをt.references :userで作れる。
referenceとforeign_keyは組で使用。

prefectureなどは、modelで操作できるのでidさえあれば良いものかと。

imageはcarrier_waveで管理すると思われ

## user_table
|Column|Type|Option|
|------|----|------|
|name|text||
|user_evaluation||
|points|string||
|total_sell_money|string||


## Assosiation
has_one: profile



## profile
|Column|Type|Option|
|------|----|------|
|email|text||
|password|text||
|last_name|string||
|first_name|string||
|last_name(kana)|string||
|first_name(kana)|string||
|birth_year|integer||
|birth_month|integer||
|birth_day|integer||
|credit_id|integer||
|user_id|references|foreign_key: true|

## Association
belongs_to: user
has_one: adress
has_one: send_adress

## Adress
|Column|Type|Option|
|------|----|------|
|postal_code|integer||
|prefecture|integer||
|city_name|string||
|building_name|string||
|profile_id|references|foreign_key: true|

## Association

belongs_to :profile


## Send_adress
|Column|Type|Option|
|------|----|------|
|postal_code|integer||
|prefecture|integer||
|city_name|string||
|building_name|string||
|profile_id|references|foreign_key: true|

## Association
belongs_to :profile

## Item
|Column|Type|Option|
|------|----|------|
|name|string||
|size|integer||
|brand|string||
|shopping_satus|integer||
|send_burden||
|shopping_method||
|prefecture|integer||
|delivery_date|integer||
|price|integer||
|comments_id|integer||

