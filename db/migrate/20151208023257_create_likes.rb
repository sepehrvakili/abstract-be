class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :likeable_id, null: false
      t.string :likeable_type, null: false
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
    add_index :likes, :likeable_id
    add_index :likes, :likeable_type
  end
end
