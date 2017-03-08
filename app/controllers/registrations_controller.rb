class RegistrationsController <  DeviseTokenAuth::RegistrationsController

  before_action :validate_phone

  private

  def validate_phone
    phone = params[:phone]
    if phone.nil? or phone.empty?
      err = {}
      err['error'] = 'Phone number is mandatory'
      render :json => err , :status=>403
    end
    p "Phone is #{phone}"
    @user = User.where(:phone => phone).first
    if @user
      err = {}
      err['error'] = 'phone number already in use'
      render :json => err , :status=>403
    end
  end

  def sign_up_params
    params.require(:registration).permit(:phone,:email,:password,:password_confirmation,:phone,:name)
  end


  def render_create_success
    # here, the @resource is accessible, in your case, a User instance.
    p 'here'
    p @resource.uid
    UserMailer.welcome_email(@resource).deliver
    p 'Mailed!!!'
    render :json=> {:status => 'success', :data => @resource.as_json}
  end


end
