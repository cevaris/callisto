class UsersController < ApplicationController
	include SessionsHelper

  def index
  	require_session
  end

  def show
    require_session
    @user = User.find params[:id]
  end

  def stream
		require_session
  	@user = current_user
  	@activities = Activity.all
  end

  def new
    @user = User.new
  end

  def update
  	require_session
  	@user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to settings_url, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      # else
      #   format.html { render action: "edit" }
      #   format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
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
