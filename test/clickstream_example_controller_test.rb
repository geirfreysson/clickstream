require File.dirname(__FILE__) + '/test_helper.rb'
#require '../test/clickstream_example_controller'
require 'action_controller/test_process'

#class ClickstreamExampleController; def rescue_action(e) raise e end; end

class ClickstreamExampleController < ActionController::Base
  
  include Clickstream
  before_filter :follow_clickstream

  def index
    render :text => "Hello world!"
  end

end

class ClickstreamExampleControllerTest < ActionController::TestCase
  def setup
    @controller = ClickstreamExampleController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new

    #ActionController::Routing::Routes.draw do |map|
    #  map.resources :woodpeckers
    #end
  end

  def test_index
    assert_difference 'Click.count' do
      get :index
      assert_response :success
    end
  end
end