class ActivitiesController < ApplicationController
    before_action :authenticate_user!

  def index
    @activities = PublicActivity::Activity.order("created_at desc")
    @activities = @activities.select{|activity| activity.trackable }
    if current_user.admin
      @activities = @activities.select{ |activity| activity.owner_id != current_user.id }
    else
      @activities = @activities.select{ |activity| activity.owner_id != current_user.id && activity.trackable.user_id == current_user.id }
    end
  end
end
