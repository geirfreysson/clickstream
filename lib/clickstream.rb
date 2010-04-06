# Clickstream
#require 'app/models/click'
#require 'app/models/stream'

%w{ models }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end

module Clickstream
  
  # replace this with any module that provides logged_in? and current_user where logged_in? returns true if there's a user
  # logged in and current_user returns that user model
  include AuthenticatedSystem

  def follow_clickstream
    cs = get_click_stream
    session[:click_stream_id] = cs.id
    if logged_in? && cs.user_id.nil?
      cs.user_id = current_user.id
      cs.save
    end
    cs.add_click(params,request.env)
  end
  
  def get_click_stream
    if session[:click_stream_id].nil?
      cs = Stream.new(:session_id=>session[:session_id])
      cs.save
    else
      cs = Stream.find(session[:click_stream_id])
    end
    return cs
  end

end
