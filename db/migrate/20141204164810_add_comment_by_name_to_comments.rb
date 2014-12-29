class AddCommentByNameToComments < ActiveRecord::Migration
  def change
    add_column :comments, :comment_by_name, :integer
  end
end
