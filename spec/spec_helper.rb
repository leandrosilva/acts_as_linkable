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
# Sample model.
#
class Payment < ActiveRecord::Base
  acts_as_linkable
end

#
# Helper methods for specs.
#
def get_mocked_payment
  payment = mock(Payment)
  
  payment.class_eval do
    include CodeZone::Acts::Linkable
    acts_as_linkable
  end
  
  payment
end