class AddDocumentIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :document_id, :integer
  end
end
