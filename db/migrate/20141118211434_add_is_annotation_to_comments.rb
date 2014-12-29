class AddIsAnnotationToComments < ActiveRecord::Migration
  def change
    add_column :comments, :isAnnotation, :boolean
  end
end
