class AddDocumentNameToComments < ActiveRecord::Migration
  def change
    add_column :comments, :document_name, :string
  end
end
