class CreateBuys < ActiveRecord::Migration[5.2]
  def change
    create_table :buys, id: :integer do |t|
    	t.integer :item_id, foreign_key: true
    	t.integer :user_id, foreign_key: true
      t.timestamps
    end
  end
end
