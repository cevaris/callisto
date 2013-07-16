class UserActivitiesController < ApplicationController

	before_filter :require_session, 
		:only => [:create, :accept, :complete, :forfeit]

	def show 
		Rails.logger.info params
		@activity = Activity.find params[:activity_id]
		@user = current_user || false

		if @user
			@user_activity = UserActivity.find_by_user_id_and_activity_id @user.id, @activity.id
		else
			@user_activity = UserActivity.find params[:id]
		end

		unless @user_activity
			render 'static_pages/404', :status => 404
		end

	end

	
	def accept
  	@activity = Activity.find params[:activity_id]
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
  	@activity = Activity.find params[:activity_id]
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
  	@activity = Activity.find params[:activity_id]
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
