class AddAttachmentFotoToImages < ActiveRecord::Migration
  def self.up
    change_table :images do |t|
      t.attachment :foto
    end
  end

  def self.down
    remove_attachment :images, :foto
  end
end
