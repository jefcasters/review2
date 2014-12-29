class AddCreatedByToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :created_by, :string
  end
end
