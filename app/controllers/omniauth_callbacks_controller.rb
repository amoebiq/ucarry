class OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController

  def omniauth_success

    p 'Here in custom auth'
    get_resource_from_auth_hash
    create_token_info
    set_token_on_resource
    create_auth_params

    if resource_class.devise_modules.include?(:confirmable)
      # don't send confirmation email!!!
      @resource.skip_confirmation!
    end

    sign_in(:user, @resource, store: false, bypass: false)

    @resource.save!

    yield @resource if block_given?

    render_data_or_redirect('deliverCredentials', @auth_params.as_json, @resource.as_json)
  end

  def omniauth_failure
    @error = params[:message]
    render_data_or_redirect('authFailure', {error: @error})
  end

end
