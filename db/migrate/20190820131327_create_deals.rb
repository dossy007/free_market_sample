class CreateDeals < ActiveRecord::Migration[5.2]
  def change
    create_table :deals,id: :integer do |t|
    	t.integer :item_id, foreign_key: true
    	t.integer :seller_id, foreign_key: true
    	t.integer :buyer_id
    	t.timestamps
    end
  end
end
