class SessionsController <  DeviseTokenAuth::SessionsController

  before_action :phone_email

  private
  def phone_email

    p 'In before action in sessions controller'



    if params[:phone].present?

      @user = User.where(:phone => params[:phone]).first
      p "User is #{@user}"
      if @user.nil?
        p 'User is emoty dude'
        render json: {
            errors: [I18n.t("devise_token_auth.sessions.bad_credentials")]
        }, status: 401
      else
      params[:email] = @user.uid
      end
      end

    p 'new creds'
    p params


  end


  def sign_in_params
    params.require(:session).permit(:phone,:email,:password)
  end


  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end


  # POST /resource/sign_in
  # Resets the authentication token each time! Won't allow you to login on two devices
  # at the same time (so does logout).
  # def create
  #   self.resource = warden.authenticate!(auth_options)
  #   sign_in(resource_name, resource)
  #
  #   current_user.update authentication_token: nil
  #
  #   respond_to do |format|
  #     format.json {
  #       render :json => {
  #                  :user => current_user,
  #                  :status => :ok,
  #                  :authentication_token => current_user.authentication_token
  #              }
  #     }
  #   end
  # end
  #
  # # DELETE /resource/sign_out
  # def destroy
  #
  #   respond_to do |format|
  #     format.json {
  #       if current_user
  #         current_user.update authentication_token: nil
  #         signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
  #         render :json => {}.to_json, :status => :ok
  #       else
  #         render :json => {}.to_json, :status => :unprocessable_entity
  #       end
  #
  #
  #     }
  #   end
  # end




end
