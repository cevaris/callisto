class FriendshipsController < ApplicationController
	# include Amistad::FriendModel
	
	def index
    @current_user = current_user
    Rails.logger.info @current_user.friends.inspect
    render 'users/friends'
    # @friends = current_user.friends
    # @pending_invited_by = current_user.pending_invited_by
    # @pending_invited = current_user.pending_invited
  end

  def update
    inviter = User.find_by_id(params[:id])
    if current_user.approve inviter
      redirect_to new_friend_path, :notice => "Successfully confirmed friend!"
    else
      redirect_to new_friend_path, :notice => "Sorry! Could not confirm friend!"
    end
  end

  def requests
		@current_user = current_user
    @pending_requests = current_user.pending_invited_by
    Rails.logger.info @current_user.inspect
  end
  
  def invites
    @pending_invites = current_user.pending_invited
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
    respond_to do |format|
			if @current_user.approve(@friend)
				format.html { render :nothing => true, :status => 200 }
			else
				format.html { render :nothing => true, :status => 500 }
			end
    end
  end

  def deny
   	@friend = User.find params[:friend_id]
    @current_user = current_user
    respond_to do |format|
			if @current_user.remove_friendship(@friend)
				format.html { render :nothing => true, :status => 200 }
			else
				format.html { render :nothing => true, :status => 500 }
			end
    end
  end
end
