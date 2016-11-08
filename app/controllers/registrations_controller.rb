class RegistrationsController <  DeviseTokenAuth::RegistrationsController

  before_action :validate_phone

  private

  def validate_phone
    phone = params[:phone]
    p "Phone is #{phone}"
    @user = User.where(:phone => phone).first
    if @user
      err = {}
      err['error'] = 'phone number already in use'
      render :json => err , :status=>403
    end
  end

  def sign_up_params
    params.require(:registration).permit(:phone,:email,:password,:password_confirmation,:phone)
  end


  def render_create_success
    # here, the @resource is accessible, in your case, a User instance.
    p 'here'
    render :json=> {:status => 'success', :data => @resource.as_json}
  end


end
