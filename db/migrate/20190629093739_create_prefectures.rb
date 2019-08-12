class CreatePrefectures < ActiveRecord::Migration[5.2]
  def change
    create_table :prefectures,id: :integer do |t|

      t.timestamps
    end
  end
end
