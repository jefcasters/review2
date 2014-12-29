class AddCommentByToComments < ActiveRecord::Migration
  def change
    add_column :comments, :comment_by, :integer
  end
end
