class StaticPagesController < ApplicationController
  def home
    redirect_to @current_user if signed_in?
  end
  
  def help
  end
  
  def about
  end
  
  def contact
  end

  def page404
  	render '404'
  end

  def page500
  	render '500'
  end
end
