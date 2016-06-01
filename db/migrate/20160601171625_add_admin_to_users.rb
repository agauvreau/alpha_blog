class AddAdminToUsers < ActiveRecord::Migration
  def change
    #this will add the admin column to the users table. It is a boolean to check with a true false statement if the user can or cannot do certain tasls
    add_column :users, :admin, :boolean, default: false
  end
end
