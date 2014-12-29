class AddIsAnnotationAndJsonToComments < ActiveRecord::Migration
  def change
    add_column :comments, :isAnnotation, :boolean, default: false
    add_column :comments, :json, :string
  end
end
