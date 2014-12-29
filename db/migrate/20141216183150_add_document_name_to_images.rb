class AddDocumentNameToImages < ActiveRecord::Migration
  def change
    add_column :images, :document_name, :string
  end
end
