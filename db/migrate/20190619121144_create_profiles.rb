class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :last_name
      t.string :first_name
      t.string :last_kana
      t.string :first_kana
      t.integer :birth_year
      t.integer :birth_month
      t.integer :birth_day
      t.integer :credit_id
      t.references :user
      t.timestamps
    end
  end
end
