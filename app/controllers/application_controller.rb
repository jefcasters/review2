class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :record_user_activity







  def after_sign_in_path_for(resource)
    if admin?
      users_path
    else
      super
    end
  end


  def admin?
    current_user.admin
  end

  rescue_from CanCan::AccessDenied do |exception|
   redirect_to user_documents_path(current_user.id), :notice => "you were not authorized to acces this page and have been redirected"
  end

  def set_user
    if(current_user.admin)
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
  end
  helper_method :set_user
  hide_action :set_user

  def get_current_user
    current_user
  end
  helper_method :get_current_user
  hide_action :get_current_user
  private

   def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end



  def set_document
    @document = Document.find(params[:document_id])
  end

  def record_user_activity
    if current_user
      current_user.touch :last_active_at
    end
  end

end
