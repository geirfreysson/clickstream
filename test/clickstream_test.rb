#require 'test_helper'
require File.dirname(__FILE__) + '/test_helper.rb'

class ClickstreamTest < ActiveSupport::TestCase
  load_schema
  
  # Replace this with your real tests.
  test "creation of Click and Stream models" do
    assert_kind_of Click, Click.new
    assert_kind_of Stream, Stream.new
  end
end
