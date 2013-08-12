module UserActivitiesHelper

	def active_privacy_friends(user_activity)
		if UserActivity::FRIENDS == user_activity.privacy
			'active'
		else
			''
		end 
	end

	def active_privacy_only_me(user_activity)
		if UserActivity::ONLY_ME == user_activity.privacy
			'active'
		else
			''
		end 
	end

	def active_privacy_public(user_activity)
		if UserActivity::PUBLIC  == user_activity.privacy
			'active'
		else
			''
		end 
	end
end
