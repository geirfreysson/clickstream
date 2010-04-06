class Click < ActiveRecord::Base
  
  set_table_name :cs_plugin_clicks
  
  belongs_to :stream

  
end