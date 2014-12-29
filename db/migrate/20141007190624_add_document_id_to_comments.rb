class AddDocumentIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :document_id, :integer
  end
end
