class AddColumnToItem < ActiveRecord::Migration[5.2]
  def change
  	add_reference :items, :image, foreign_key: true, type: :integer
    add_reference :items, :category, foreign_key: true, type: :integer
  end
end
