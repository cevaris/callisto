module SessionsHelper
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user

    self.current_user.update_authtoken
    self.current_user.save
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    if !@current_user and params.has_key?(:authtoken)
      @current_user ||= User.find_by_authtoken(params[:authtoken])
    end
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def require_session
    unless current_user
    	flash[:error] = 'You must be logged in to view this page.'  
      redirect_to signin_path
    end
  end
  
end
