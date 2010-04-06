class Stream < ActiveRecord::Base
  
  set_table_name :cs_plugin_streams
  has_many :clicks
  belongs_to :user
  
  # pass args such as 1.week.ago
  named_scope :since, lambda { |since| { :include=>[:clicks,:user], :conditions => ['cs_plugin_streams.created_at > ?', since], :order=>'created_at desc' } }
  
  def add_click(params,env)
    click = Click.new(:action=>params[:action],
                      :controller=>params[:controller],
                      :path_info=>env["PATH_INFO"],
                      :request_path=>env["REQUEST_PATH"],
                      :request_uri=>env["REQUEST_URI"],
                      :http_user_agent=>env["HTTP_USER_AGENT"],
                      :http_referer=>env["HTTP_REFERER"],
                      :remote_address=>env["REMOTE_ADDR"])
    self.clicks << click
    click.save
  end
  
  
  #Calculates the duration of this stream using the time of the first click and the time of the last click.
  def duration
    if self.clicks.size > 1
       self.clicks.last.created_at - self.clicks.first.created_at
    else
      0
    end
  end
  
end