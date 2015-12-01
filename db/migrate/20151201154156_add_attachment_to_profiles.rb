class AddAttachmentToProfiles < ActiveRecord::Migration
  def up
    add_attachment :profiles, :picture
  end

  def down
    remove_attachment :profiles, :picture
  end
end
