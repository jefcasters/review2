class RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, only: [ :cancel ]
  prepend_before_filter :authenticate_scope!, only: [:edit, :update]
  prepend_before_filter :authenticate_scope!, only: [:destroy]


  def destroy
    authorize! :delete, @user
    # @user.destroy
    # # Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    # set_flash_message :notice, :destroyed if is_flashing_format?
    # yield resource if block_given?
    # respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
    @user = User.find(params[:user_to_delete])
    if @user.destroy
      redirect_to root_path
    else
     render plain: "I was not able to delete the user"
   end


  end

  def new
    authorize! :create, @user
    super
  end

  def sign_up(resource_name, resource)
    # Logs new created users in after registering them
    # comment it out when finishing application
    # sign_in(resource_name, resource)
  end

  def create
    authorize! :create, @user
    super
    if @user.save
      # Tell the UserMailer to send a welcome email after save
      NotificationMailer.welcome_email(@user).deliver
    end
  end

  def edit
    authorize! :update, @user
    super
  end

  def update
    authorize! :update, @user
    super
  end





# #cancel
#        user_registration                                  registrations#create
#    new_user_registration GET                registrations#new
#   edit_user_registration GET            registrations#edit
#                          PATCH               registrations#update
#                          PUT                      registrations#update


  private

  def sign_up_params
    params.require(:user).permit( :name, :email, :password, :password_confirmation, :admin)
  end

  def account_update_params
    params.require(:user).permit( :name, :email, :password, :password_confirmation, :current_password, :admin)
  end

  def authenticate_scope!
    send(:"authenticate_#{resource_name}!", force: true)
    self.resource = send(:"current_#{resource_name}")
  end
end
