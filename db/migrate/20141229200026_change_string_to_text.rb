class ChangeStringToText < ActiveRecord::Migration
  def up
    change_column :comments, :json, :text
  end
  def down
    # This might cause trouble if you have strings longer
    # than 255 characters.
    change_column :comments, :json, :string
  end
end
