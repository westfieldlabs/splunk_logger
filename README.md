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
The first argument should be a unique keyword to identify the event. The second
argument should be key-value pairs in a hash, e.g.:

    SplunkLogger::Logger.error('EventCode', {'foo': 'bar'} )
    SplunkLogger::Logger.error('EventCode',  {'job_status_id': '45', 'err_msg':'Missing mandatory field X'})
    
Use `#trace` to log lines of a backtrace from an exception e.g.

    rescue => err
      SplunkLogger::Logger.trace(err, err.backtrace[0..5])
