# SplunkLogger

A lightweight wrapper around Logger to optimize Splunk queries

## Installation

Add this line to your application's Gemfile:

    gem 'splunk_logger', git: 'https://github.com/westfield/splunk_logger.git'

## Usage
No configuration is required. In your code, replace `logger.debug` with 
`SplunkLogger::Logger.debug`. SplunkLogger::Logger will call #debug on the first of 
Rails.logger, App::Logger, or Logger.new. 

To force SplunkLogger to write to a different logger: 

    MyLogger = Logger.new(_file_)
    SplunkLogger::Logger.logger = MyLogger
    
SplunkLogger::Logger responds to all of the standard Logger methods plus `#trace`. 
The first argument should be a unique keyword to identify the event. Additional
arguments are converted to key/value pairs to enable automatic variable creation in 
Splunk (e.g.: job_status_id="435432" err_msg="Missing mandatory field X")

    SplunkLogger::Logger.error('EventCode', 'foo', 'bar' )
    SplunkLogger::Logger.error('EventCode', 'foo', 'bar', 'baz' )

The last example would generate a log entry including `EventCode foo="bar" baz=""`
    
Use `#trace` to log lines of a backtrace from an exception e.g.

    rescue => err
      SplunkLogger::Logger.trace(err, err.backtrace[0..5])
