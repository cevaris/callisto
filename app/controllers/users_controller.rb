class UsersController < ApplicationController

  def index
    # /users/ was returning a 404
    return_to signin_url if !signed_in?
    redirect_to @current_user
  end

  def show
    # Users must be signed in to view a profile
    redirect_to signin_url if !signed_in?

    @user = User.find params[:id]
    if !@user
      Rails.logger.info 'Could not locate user '
      return render :status => 404
    end

  end

  def new
    redirect_to @current_user if signed_in?
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = t('signup.welcome', app_name: t('global.app_name'))
      redirect_to @user
    else
      render 'new'
    end
  end

end
