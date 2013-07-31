class SessionsController < ApplicationController
	# skip_authorization_check :only => [:new, :create]
	
  def new
    @user = User.new
  end

  def create
    Rails.logger.info params
    
    if request.env.has_key?('omniauth.auth')
      auth_hash = request.env['omniauth.auth']
      Rails.logger.info "Auth Hash #{auth_hash.inspect}"
    end

    # user = User.find_by_email(params[:session][:name].downcase)

    # if user && user.authenticate(params[:session][:password])
    #   sign_in user
    #   # redirect_to user
    #   redirect_to root_path
    # else
    #   flash.now[:error] = t 'signin.error'
    #   render 'new'
    # end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
  
end
