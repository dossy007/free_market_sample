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


## user_table
|Column|Type|Option|
|------|----|------|
|name|text||
|user_evaluation||
|points|string||
|total_sell_money|string||


## Assosiation




## profile
|Column|Type|Option|
|------|----|------|
|email|text||
|password|text||
|last_name|string||
|first_name|string||
|last_name(kana)|string||
|first_name(kana)|string||
|birth_day|integer||
|credit_id|integer||
|user_id|references|foreign_key: true|