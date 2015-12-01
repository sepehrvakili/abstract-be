class AddIndexToUsernameEmailOnUsers < ActiveRecord::Migration
  def change
    add_index :users, :username
    add_index :users, :email
  end
end
