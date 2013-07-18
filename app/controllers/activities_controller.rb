class ActivitiesController < ApplicationController

	before_filter :require_session, 
		:only => [:new, :create, :update, :destroy]

  # GET /activities
  # GET /activities.json
  def index
  	@activities = Activity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end


  def filter_tags
	  @tags = ActsAsTaggableOn::Tag.where("tags.name LIKE ?", "%#{params[:typeahead]}%")
	  @tag_results = [] 
	  @tags.each do |tag| # Need to build hash
	  	@tag_results.push({tag: tag.name})
	  end

		respond_to do |format|
      format.json { render json: {tags: @tag_results} }
    end
  end

  def filter

   	@activities = activity_tags = activity_names = []

    if params.has_key?('filter_activity_text') and !params[:filter_activity_text].empty?
      activity_names = Activity.where( Activity.arel_table[:name].matches("%#{params[:filter_activity_text].strip}%") )
    end

    if params.has_key?('filter_activity_tags') and !params[:filter_activity_tags].empty?
    	tags = ActsAsTaggableOn::Tag.where(id: params[:filter_activity_tags]) 
    	if !tags.empty?
      	activity_tags = Activity.tagged_with(tags.pluck(:name), :any => true)
      end
    end

    # Combine results
    @activities = activity_tags + activity_names
    # return results
    @activities.uniq!

    render partial: 'activities/table_activities'
  end


  def unwatch
  	@activity = Activity.find params[:activity_id]
		@current_user = current_user || false

  	respond_to do |format|
			if @current_user and @current_user.stop_following(@activity)
				Rails.logger.info "#{@current_user.name} is no longer watching #{@activity.name}"
				format.html { render :nothing => true, :status => 200 }
			else
				format.html { render :nothing => true, :status => 500 }
			end
    end
  end

  def watch
  	@activity = Activity.find params[:activity_id]
		@current_user = current_user || false

  	respond_to do |format|
			if @current_user and @current_user.follow(@activity)
				Rails.logger.info "#{@current_user.name} is now watching #{@activity.name}"
				format.html { render :nothing => true, :status => 200 }
			else
				format.html { render :nothing => true, :status => 500 }
			end
    end
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    @activity = Activity.find(params[:id])

    if current_user
    	@user = current_user
    	@user_activity = UserActivity.find_by_user_id_and_activity_id @user.id, @activity.id
    	
    	Rails.logger.info "#{@user_activity.inspect}"
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/new
  # GET /activities/new.json
  def new
    @activity = Activity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    @activity = Activity.find(params[:id])

    images_left = (5 - @activity.activity_images.count)
    images_left.times { @activity.activity_images.build }

    Rails.logger.info "Activity: #{@activity.name}"

    # authorize edits only after the first day of activity creation
    if @activity.created_at < 1.day.ago
    	authorize! :edit, @activity
    end

  end

  # POST /activities
  # POST /activities.json
  def create

    @activity = Activity.new(params[:activity])
    @activity.user = current_user

    if params.has_key?('hidden-activity') and params['hidden-activity'].has_key?('tag_list')
    	params[:activity][:tag_list] = params['hidden-activity'][:tag_list]
    end

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render json: @activity, status: :created, location: @activity }
      else
        format.html { render action: "new" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /activities/1
  # PUT /activities/1.json
  def update
    @activity = Activity.find(params[:id])

    if params.has_key?('hidden-activity') and params['hidden-activity'].has_key?('tag_list')
    	params[:activity][:tag_list] = params['hidden-activity'][:tag_list]
    end

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
    
    if @activity.created_at < 1.day.ago
    	authorize! :edit, @activity
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :no_content }
    end

    if @activity.created_at < 1.day.ago
    	authorize! :edit, @activity
    end
  end
end
