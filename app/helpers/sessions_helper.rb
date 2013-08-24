module SessionsHelper
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user

    # @current_user ||= User.find_by_remember_token(cookies[:remember_token])

    if request.headers.has_key?('HTTP_DATA_AUTHTOKEN') and request.headers.has_key?('HTTP_DATA_EMAIL')
      @current_user = User.find_by_authtoken(request.headers['HTTP_DATA_AUTHTOKEN'])

    else
      @current_user ||= User.find_by_remember_token(cookies[:remember_token])
      
    end

    @current_user
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
