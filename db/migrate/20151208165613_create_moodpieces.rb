class CreateMoodpieces < ActiveRecord::Migration
  def change
    create_table :moodpieces do |t|
      t.string :div_id, null: false
      t.string :color
      t.references :post, index: true, foreign_key: true
      t.attachment :image

      t.timestamps null: false
    end
  end
end
