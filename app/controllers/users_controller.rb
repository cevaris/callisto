class UsersController < ApplicationController

	before_filter :require_session, 
		:only => [:watching, :accepted, :completed, :following,
							:unfollow, :follow, :update,
							:followers
						 ]

	def home
    if signed_in?
    	@user = current_user
    	max_num_results = 20
    	@completed = @user.activities_completed.limit(max_num_results).order('updated_at DESC')
    	@accepted = @user.activities_accepted.limit(max_num_results).order('updated_at DESC')
    	@watching = @user.activities_watching.limit(max_num_results).order('updated_at DESC')
    	@following = @user.activities_following.limit(max_num_results).order('updated_at DESC')

    else
    	render 'static_pages/home'
    end
  end

  def wall
  	@user = User.find params[:user_id]
    @user_activities = @user.user_activities
    @current_user = current_user || @user

    @wall_content = []

    @user_activities.each do |user_activity|
    	# Add images
    	user_activity.user_activity_images.each do |user_activity_image|
    		if !user_activity_image.nil?
    			@wall_content << [user_activity, 'IMAGE', user_activity_image]
    		end
    	end
    	# Add video
    	if !user_activity.video_url.blank?
    		@wall_content << [user_activity, 'VIDEO', user_activity.video_url]
    	end
    end

    @wall_content.shuffle!

    if !@wall_content.empty?
    	@no_container = true
    end	

   
  end 

  def show
    @user = User.find params[:id]
    @current_user = current_user
  end

  def watching
  	@user = current_user
  	@activities = @user.activities_watching.order('updated_at DESC')
  	render 'activities'
  end

 	def accepted
  	@user = current_user
  	@activities = @user.activities_accepted.order('updated_at DESC')
  	render 'user_activities'
  end

  def following
		@user = current_user
  	@activities = @user.activities_following.order('updated_at DESC')
  	render 'user_activities'
  end

  def followers
		@user = current_user
  	@users = @user.followers.order('created_at DESC')
  	Rails.logger.info @users.inspect
  end

  def completed
  	@user = current_user
  	@activities = @user.activities_completed.order('updated_at DESC')
  	render 'user_activities'
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
      redirect_to root_path
    else
      render 'new'
    end
  end

end
