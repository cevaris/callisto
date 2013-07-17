class UsersController < ApplicationController
	# skip_authorization_check :only => [:new, :create]

	def home
    if signed_in?
    	@user = current_user
  		@activities = Activity.all
    else
    	render 'static_pages/home'
    end
  end

  def show
    @user = User.find params[:id]
    @activities = @user.activities
    @current_user = current_user 
  end


  def unfollow
  	@user = User.find params[:user_id]
		@current_user = current_user || false

  	respond_to do |format|
			if @current_user and @current_user.stop_following(@user)
				format.html { render :nothing => true, :status => 200 }
			else
				format.html { render :nothing => true, :status => 500 }
			end
    end
  end

  def follow
  	@user = User.find params[:user_id]
		@current_user = current_user || false

  	respond_to do |format|
			if @current_user and @current_user.follow(@user)
				format.html { render :nothing => true, :status => 200 }
			else
				format.html { render :nothing => true, :status => 500 }
			end
    end
  end

  def new
    @user = User.new
  end

  def update
  	@user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to settings_url, notice: 'User was successfully updated.' }
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
