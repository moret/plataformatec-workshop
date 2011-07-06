require 'spec_helper'

describe Attachment do
  describe "#available_name" do
    it "should return the url if no name is available" do
      attachment = Factory.build(:attachment, :name => "")
      attachment.available_name =~ %r(^/uploads/)
    end

    it "should return name if available" do
      Factory.create(:attachment, :name => "Rails Logo").available_name.should == "Rails Logo"
    end
  end
end
