class UtilController < ApplicationController
	include UtilHelper

	def ajax_auto_html

		@video_url = false

		if params.has_key?(:url) and uri?(params[:url])
			@video_url = params[:url]
		end

		respond_to do |format|
			if @video_url
				format.html { render :partial => 'video', :layout=>false }
			else
				format.html { render :nothing => true, :status => 200 }
			end
    end

	end

end
