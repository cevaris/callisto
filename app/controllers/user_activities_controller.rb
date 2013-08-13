class UserActivitiesController < ApplicationController

	before_filter :require_session, 
		:only => [:create, :accept, :complete, :forfeit, :new, :edit, :update, :privacy_state]

	def show 
		@user_activity = UserActivity.find params[:id]
		@activity = @user_activity.activity
		@user = @user_activity.user
		@current_user = current_user

		unless @user_activity and @user_activity.can_view?(@current_user)
			render 'static_pages/404', :status => 404
		end
	end

	def edit
		@activity = Activity.find params[:activity_id]
		@user_activity = UserActivity.find params[:id]
		@user = current_user || false

		if @user
			images_left = (UserActivity::MAX_PHOTOS - @user_activity.user_activity_images.count)
    	images_left.times { @user_activity.user_activity_images.build }
		end

		unless @user_activity
			render 'static_pages/404', :status => 404
		end
		unless @user.id == @user_activity.user.id
			authorize! :edit, @user_activity
		end
	end

	def update
  	@activity = Activity.find params[:activity_id]
  	@user_activity = UserActivity.find params[:id]
		@user = current_user || false		

		@has_permission = @user

    respond_to do |format|
      if @has_permission and @user_activity.update_attributes(params[:user_activity])
        format.html { redirect_to activity_user_activity_url(@activity, @user_activity), notice: 'Your Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
      end
    end

  	unless @user.id == @user_activity.user.id
			authorize! :edit, @user_activity
		end

  end

	def accept
		@user_activity = UserActivity.find params[:user_activity_id]
		@user = current_user || false

  	update_action(:accept)

  	respond_to do |format|
			if @user_activity.save
				format.html { render :partial => 'action', :layout=>false }
			else
				format.html { render :nothing => true, :status => 500 }
			end
    end
  end

  def complete
		@user_activity = UserActivity.find params[:user_activity_id]
		@user = current_user || false

  	update_action(:complete)

  	respond_to do |format|
			if @user_activity.save
				format.html { render :partial => 'action', :layout=>false }
			else
				format.html { render :nothing => true, :status => 500 }
			end
    end

  end

  def forfeit
		@user_activity = UserActivity.find params[:user_activity_id]
		@user = current_user || false

  	update_action(:forfeit)

  	respond_to do |format|
			if @user_activity.save
				format.html { render :partial => 'action', :layout=>false }
			else
				format.html { render :nothing => true, :status => 500 }
			end
    end
  	
  end

  def create
    @activity = Activity.find params[:activity_id]

    @user_activity = UserActivity.new
    @user_activity.activity = @activity
    @user_activity.activity_state = ActivityState.find_by_name ActivityState::ACCEPTED
    @user_activity.user = current_user

    return respond_to do |format|
    	if @user_activity.save
    		format.html { redirect_to activity_user_activity_url(@activity, @user_activity), notice: 'Activity was successfully accepted.' }
    	else
  			format.html { redirect_to @activity, error: 'Activity could not be accepted.' }
    	end
    end
  end

  def privacy_state

  	@user_activity = UserActivity.find params[:id]
  	@user_activity.privacy = params[:state]
		
		respond_to do |format|
			if @user_activity.save
				format.html { render :nothing => true, :status => 200 }
			else
				format.html { render :nothing => true, :status => 500 }
			end
    end

  end

  private 

  def update_action(request)

  	case request
	  	when :accept
	  		state = ActivityState.find_by_name ActivityState::ACCEPTED
	  	when :complete
	  		state = ActivityState.find_by_name ActivityState::COMPLETED
	  	when :forfeit
	  		state = ActivityState.find_by_name ActivityState::FORFEITED
	  	end

		@user_activity.activity_state = state
  end

end
