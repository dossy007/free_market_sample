class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :size
      t.string :brand
      t.integer :shopping_status
      t.integer :send_burden
      t.integer :shopping_method
      t.integer :prefecture
      t.integer :delivery_date
      t.integer :price
      t.text :text
      t.integer :good_function
      t.timestamps
    end
  end
end
# t.references :comment, foreign_key: true
# 外部制約のcommentは後ほど作成します