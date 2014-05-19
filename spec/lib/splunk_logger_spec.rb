require 'spec_helper'
require 'splunk_logger'
require 'logger'

shared_context "logger methods" do |target_logger|
  describe "it responds to" do 
    ["debug", "info", "warn", "error", "fatal"].each { |e| 
      it e do
        target_logger.should_receive(e)
        SplunkLogger::Logger.send(e, "ErrorCode", "key")
      end
    } 
  end
end

TestLogger = Logger.new(STDOUT)
 
describe SplunkLogger do

  subject { SplunkLogger::Logger }

  describe "when logger is" do
  
    before(:each) { 
      subject.logger = nil
    }
    after(:each) { 
      subject.logger = nil
    }

#     describe "undefined" do
#       include_context "logger methods", Logger.new(STDOUT)
#     end

    describe "Logger.new" do

      before(:each) { 
        subject.logger = nil
        subject.logger = TestLogger
      }
      include_context "logger methods", TestLogger
    end

    describe "App::Logger" do
      module App
        Logger = ::Logger.new(STDOUT)
      end

      before(:each) { 
        subject.logger = nil
      }
      include_context "logger methods", App::Logger
    end

    describe "Rails.logger" do
      it "is pending mocking a Rails.logger"
    end
  end

  describe "errors on" do
    it "arbitrary logger method" do
      lambda { subject.fail('ERROR_CODE') }.should raise_exception
    end

    it "nil arg key" do
      lambda { subject.error }.should raise_exception
    end
  end
  
  describe "argument formats" do
    
    describe "message" do

      it "works" do
        subject.message(
          'ERROR_CODE', {:key_symbol1 => 'value 1', 'key string2' => 'value 2'}
        ).should == %Q{ERROR_CODE key_symbol1="value 1" key_string2="value 2"}
      end

    end

    describe "trace" do
      before :each do
        logger = double() 
        logger.stub(:trace)
        subject.logger = logger
        msg = %q{TRACE
ERROR_CODE
line 1
line 2
line 3}
        subject.logger.should_receive(:error).at_least(:once).with(msg)
      end

      it "list" do
        subject.trace('ERROR_CODE', "line 1", "line 2", "line 3" )
      end 
      
      it "array" do
        subject.trace('ERROR_CODE', ["line 1", "line 2", "line 3"] )
      end 
      
    end
  
  end
end
