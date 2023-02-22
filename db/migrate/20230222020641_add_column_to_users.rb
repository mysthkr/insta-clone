class AddColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :user_image, :text
  end
end
