class Comment < ActiveRecord::Base
  include PublicActivity::Model

  # tracked owner: -> (controller, model) { controller && controller.set_user }
  tracked owner: -> (controller, model) { controller && controller.get_current_user }

  belongs_to :image

  # after_save do
  #   document.update_attribute(:admin_notification, true)
  # end
end
