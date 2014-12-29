class RemoveImgFileNameAndImgContentTypeAndImgFileSizeAndImgUpdatedAtFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :img_file_name, :string
    remove_column :images, :img_content_type, :string
    remove_column :images, :img_file_size, :integer
    remove_column :images, :img_updated_at, :datetime
  end
end
