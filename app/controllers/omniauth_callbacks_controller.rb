class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end

# class OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
#
#   def omniauth_success
#
#     p 'Here in custom auth'
#     get_resource_from_auth_hash
#     create_token_info
#     set_token_on_resource
#     create_auth_params
#
#     if resource_class.devise_modules.include?(:confirmable)
#       # don't send confirmation email!!!
#       @resource.skip_confirmation!
#     end
#
#     sign_in(:user, @resource, store: false, bypass: false)
#
#     @resource.save!
#
#     yield @resource if block_given?
#
#     render_data_or_redirect('deliverCredentials', @auth_params.as_json, @resource.as_json)
#   end
#
#   def omniauth_failure
#     @error = params[:message]
#     render_data_or_redirect('authFailure', {error: @error})
#   end
#
# end
