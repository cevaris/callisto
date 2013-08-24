class MobileIosController < ApplicationController

	skip_before_filter :verify_authenticity_token, only: [:signin]
  after_filter do
    Rails.logger.info response.body
  end

	def signin

    @user = User.find_by_email(params[:email].downcase)

    respond_to do |format|
    	if @user and @user.authenticate(params[:password])
    		sign_in @user
        format.json { render json: @user, status: 200 }
      else
        format.json { render json: @user.errors, status: 500 }
      end
    end
	end
	
	def user
    Rails.logger.info params
    # Rails.logger.info request.headers
    Rails.logger.info request.headers['HTTP_DATA_AUTHTOKEN']
    Rails.logger.info request.headers['HTTP_DATA_EMAIL']

    if request.headers.has_key?('HTT_DATA_AUTHTOKEN') and request.headers.has_key?('DATA_EMAIL')
      @user = User.find_by_authtoken(request.headers['HTTP_DATA_AUTHTOKEN'])
    end

    respond_to do |format|
    	if @user and @user.email == request.headers['DATA_EMAIL']
        format.json { render json: @user, status: 200 }
      else
        format.json { render :json => {:error_message => 'User not found'}, status: 500 }
      end
    end
	end

	def my_activities


    respond_to do |format|
    	if @user
    		sign_in @user
        format.json { render json: @user, status: 200 }
      else
        format.json { render json: @user.errors, status: 500 }
      end
    end
	end

	def filter_activities
	end

end
