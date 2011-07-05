require 'spec_helper'

describe ApplicationHelper do
  describe "#flash_messages" do
    it "should show flash messages" do
      helper.stub!(:flash).and_return({:notice => "True", :alert => "False"})
      helper.flash_messages.should be_html_safe
      helper.flash_messages.should == %(<p id="flash_notice">True</p><p id="flash_alert">False</p>)
    end

    it "should ignore blank messages" do
      helper.stub!(:flash).and_return({:notice => ""})
      helper.flash_messages.should == ""
    end
    
    it "should ignore invalid keys" do
      helper.stub!(:flash).and_return({:invalid => "True"})
      helper.flash_messages.should == ""
    end
  end

  describe "#js" do
    it "should escape js and wrap it in quotes" do
      helper.js('\\').should == '"\\\\"'
      helper.js('\\').should be_html_safe
    end
  end
end
