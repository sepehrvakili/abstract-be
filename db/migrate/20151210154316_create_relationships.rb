class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps null: false
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    #This is a multiple-key index that will enforce uniqueness on the pair
    #so that a user can't follow another user more than once.
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
