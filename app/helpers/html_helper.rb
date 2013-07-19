module HtmlHelper

  def apply_google_analytics?
    Rails.logger.info("#{request.host_with_port}")
    Rails.application.config.respond_to? 'PRODUCTION_DOMAIN' and Rails.application.config.PRODUCTION_DOMAIN == request.host_with_port
  end

  def with_new_lines(string)
		(h(string).gsub(/\n/, '<br/>')).html_safe  	
  end

end
