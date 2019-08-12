class AddColumnToItem < ActiveRecord::Migration[5.2]
  def change
  	add_reference :images, :item, foreign_key: true, type: :integer
    add_reference :items, :category, foreign_key: true, type: :integer
    add_column :items, :prefecture_id, :integer
  end
end
