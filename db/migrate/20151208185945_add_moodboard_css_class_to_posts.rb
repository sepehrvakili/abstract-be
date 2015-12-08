class AddMoodboardCssClassToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :moodboard_css_class, :string
  end
end
