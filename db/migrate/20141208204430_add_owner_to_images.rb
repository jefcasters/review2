class AddOwnerToImages < ActiveRecord::Migration
  def change
    add_column :images, :owner, :integer
  end
end
