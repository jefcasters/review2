class UsersController < ApplicationController #ActionController::Base
before_action :authenticate_user!
respond_to :html

helper_method :sort_column, :sort_direction
  def index
    authorize! :read, @user
    @users = User.all.order(sort_column + " " + sort_direction)
    @user = current_user
    respond_with(@user)

  end

  private
  rescue_from CanCan::AccessDenied do |exception|
   redirect_to user_documents_path(current_user.id), :notice => "you were not authorized to acces this page and have been redirected"
  end
   def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
   end

   def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
   end

end
