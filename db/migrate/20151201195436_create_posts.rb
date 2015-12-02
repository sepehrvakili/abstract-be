class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :post_type, null: false
      t.string :title
      t.string :url
      t.string :description
      t.string :status
      t.string :quote
      t.integer :user_id, index: true, null: false

      t.timestamps null: false
    end
  end
end
