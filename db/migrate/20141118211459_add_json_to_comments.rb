class AddJsonToComments < ActiveRecord::Migration
  def change
    add_column :comments, :json, :string
  end
end
