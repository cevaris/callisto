class ActivitiesController < ApplicationController

	before_filter :require_session, 
		:only => [:new, :create, :update, :destroy]


  # GET /activities
  # GET /activities.json
  def index
  	# if signed_in?
  	# 	redirect_to @current_user 
  	# else
  	# 	render 'static_pages/home'
  	# end
  	@activities = Activity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end


  # def search
  #   @activities = Activity.all

  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @activities }
  #   end
  # end

  def filter
   
    filter = {}
    @activities = Activity.all

    if params.has_key?('filter_activity_text') and !params[:filter_activity_text].empty?
      @activities &= Activity.where( Activity.arel_table[:name].matches("%#{params[:filter_activity_text].strip}%") )
    end


    if params.has_key?('filter_activity_tags') and !params[:filter_activity_tags].empty?
      @activities &= Activity.tagged_with([params[:filter_activity_tags]], :any => true)
    end

    Rails.logger.info @activities

    render partial: 'activities/table_activities'
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
  end

  # POST /activities
  # POST /activities.json
  def create

    @activity = Activity.new(params[:activity])
    @activity.user = current_user

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

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
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
  end
end
