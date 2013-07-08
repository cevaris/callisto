class UsersController < ApplicationController
	include SessionsHelper

  def index
  	require_session
    # # /users/ was returning a 404
    # return_to signin_url if !signed_in?
    # redirect_to @current_user
  end

  def show
    # Users must be signed in to view a profile
    # redirect_to signin_url if !signed_in?
    require_session

    @user = User.find params[:id]
    if !@user
      Rails.logger.info "404 user #{params[:id]}"
      return render :status => 404
    end

  end

  def stream
		require_session
  	@user = current_user
  	@activities = Activity.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = t('signup.welcome', app_name: t('global.app_name'))
      # redirect_to @user
      redirect_to stream_path
    else
      render 'new'
    end
  end

end
