class RemoveImageAndImageFileNameAndImageContentTypeAndImageFileSizeAndImageUpdatedAtFromDocuments < ActiveRecord::Migration
  def change
    remove_column :documents, :image, :text
    remove_column :documents, :image_file_name, :string
    remove_column :documents, :image_content_type, :string
    remove_column :documents, :image_file_size, :file_size
    remove_column :documents, :image_updated_at, :datetime
  end
end
