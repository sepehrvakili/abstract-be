class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :bio
      t.string :website
      t.string :location
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :profiles, :user_id
  end
end
