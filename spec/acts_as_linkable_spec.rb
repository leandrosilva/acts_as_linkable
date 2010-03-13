require 'spec_helper'

describe 'acts_as_linkable plugin' do
  context 'when applyed to a model' do
    before(:all) do
      @model = mocked_model
    end

    it 'should add link_to method on that model' do
      @model.respond_to?(:link_to).should == true
    end
    
    it 'should add links method on that model' do
      @model.respond_to?(:links).should == true
    end
    
    it 'should add is_linked_to? method on that model' do
      @model.respond_to?(:is_linked_to?).should == true
    end        
    
    context 'and if a link is added on that model' do
      before(:all) do
        @model.link_to :registration => 'http://model.com/registration'
      end

      it 'should contains the added link on its links hash' do
        @model.links[:registration].should == 'http://model.com/registration'
      end

      it 'should is linked to the added link' do
        @model.is_linked_to?(:registration).should == true
      end        
    end
  end
end