require 'spec_helper'

describe CodeZone::Acts::Linkable do
  context 'when a Payment model acts as linkable' do
    before(:all) do
      @payment = get_mocked_payment
    end

    it 'should respond to link_to method' do
      @payment.respond_to?(:link_to).should == true
    end
    
    it 'should respond to links method' do
      @payment.respond_to?(:links).should == true
    end
    
    it 'should respond to is_linked_to? method' do
      @payment.respond_to?(:is_linked_to?).should == true
    end        
    
    context 'and if a link is added' do
      before(:all) do
        @payment.link_to :registration => 'http://payment.com/registration'
      end

      it 'should include :registration in links hash' do
        @payment.links[:registration].should == 'http://payment.com/registration'
      end

      it 'should is linked to :registration' do
        @payment.is_linked_to?(:registration).should == true
      end        
    end
  end
end