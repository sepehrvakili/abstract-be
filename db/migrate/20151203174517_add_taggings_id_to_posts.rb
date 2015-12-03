class AddTaggingsIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :taggings_id, :integer
  end
end
