ActiveRecord::Schema.define(:version => 0) do
  create_table :cs_plugin_clicks, :force => true do |t|
    t.string    :action
    t.string    :controller
    t.string    :params
    t.datetime  :created_at
    t.integer   :stream_id
    t.string    :path_info
    t.string    :request_path
    t.string    :request_uri
    t.string    :http_user_agent
    t.string    :http_referer
    t.string    :remote_address
  end
  create_table :cs_plugin_streams, :force => true do |t|
    t.string    :session_id
    t.integer   :user_id
    t.datetime  :created_at
    t.datetime  :last_click
  end  
end