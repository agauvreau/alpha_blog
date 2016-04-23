class AddUserIdToArticles < ActiveRecord::Migration
  
  #when adding column  first your specify the table, then the column to add then its type
  def change
    add_column :articles, :user_id, :integer
  end
end
