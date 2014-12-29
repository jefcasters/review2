class User < ActiveRecord::Base
  has_many :documents, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.send_notifications
    # user = User.find(24)
    # activities = PublicActivity::Activity.order("created_at desc")
    # NotificationMailer.notification_email(user,activities).deliver

    users = User.all
    activities = PublicActivity::Activity.order("created_at desc")
    activities = activities.select{|activity| activity.trackable }

    users.each do |user|
      userActivities = activities.select{|activity| activity.owner_id != user.id && activity.trackable.user_id == user.id }
      userActivities = userActivities.select{|activity| activity.created_at > user.last_active_at}
      if userActivities.last
        NotificationMailer.notification_email(user,userActivities).deliver
      end
    end


  end


end
