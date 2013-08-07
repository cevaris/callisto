class FriendshipsController < ApplicationController
	def index
    @friends = current_user.friends
    @pending_invited_by = current_user.pending_invited_by
    @pending_invited = current_user.pending_invited
  end

  def create
    @Friend = User.find(params[:user_id])
    @friendship_created = current_user.invite(@Friend)
    if @friendship_created
      flash.now[:notice] = "Une demande d'amiti a t envoye  #{@friend.fullname}"
    end
  end

  def approve
    @Friend = User.find(params[:user_id])
    @friendship_approved = current_user.approve(@Friend)
    @friends = current_user.friends
    @pending_invited_by = current_user.pending_invited_by
    flash.now[:notice] = "La demande d'amiti de #{@friend.fullname} a t approuve"
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
    @pending_requests = current_user.pending_invited_by
  end
  
  def invites
    @pending_invites = current_user.pending_invited
  end

  def destroy
    @Friend = User.find(params[:user_id])
    @friendship = current_user.send(:find_any_friendship_with, @Friend)
    if @friendship
      @friendship.delete
      @removed = true
      flash.now[:notice] = "L'amiti avec #{@friend.fullname} a t supprime"
    end
  end
end
