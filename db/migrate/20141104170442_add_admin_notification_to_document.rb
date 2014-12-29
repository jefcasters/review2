class AddAdminNotificationToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :admin_notification, :boolean
  end
end
