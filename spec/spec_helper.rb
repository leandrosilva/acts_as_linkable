require 'rubygems'
require 'active_record'
require 'rspec'

Rspec.configure do |config|
  # Remove this line if you don't want Rspec's should and should_not
  # methods or matchers
  require 'rspec/expectations'
  config.include Rspec::Matchers

  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec
end

require File.dirname(File.expand_path(__FILE__)) + '/../lib/acts_as_linkable.rb'

#
# A simple sample model.
#
class SimpleModel < ActiveRecord::Base
  acts_as_linkable
end

#
# Helper methods for specs.
#
def mocked_model
  model = mock(SimpleModel)
  
  model.class_eval do
    include CodeZone::Acts::Linkable
    acts_as_linkable
  end
  
  model
end