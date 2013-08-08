class FriendshipsController < ApplicationController
	
	def index
    @current_user = current_user
    session[:return_to] = '/friends'

    render 'users/friends'
  end

  def requests
		@current_user = current_user
    @pending_requests = current_user.pending_invited_by

    session[:return_to] = '/friends/requests'
  end

  def invite
    @friend = User.find params[:friend_id]
    @current_user = current_user
    respond_to do |format|
			if @current_user.invite(@friend)
				format.html { render :nothing => true, :status => 200 }
			else
				format.html { render :nothing => true, :status => 500 }
			end
    end
  end

  def approve
    @friend = User.find params[:friend_id]
    @current_user = current_user
    # respond_to do |format|
			if @current_user.approve(@friend)
				redirect_to session[:return_to], notice: "You are now friends with #{@friend.name}"
			else
        redirect_to session[:return_to], notice: 'Sorry, cannot add friend'
			end
    # end
  end

  def deny
   	@friend = User.find params[:friend_id]
    @current_user = current_user
    # respond_to do |format|
			if @current_user.remove_friendship(@friend)
        redirect_to session[:return_to], notice: "You are no longer friends with #{@friend.name}"
			else
				redirect_to session[:return_to], notice: 'Sorry, cannot remove friend'
			end
    # end
  end
end
