require 'logger'
require 'splunk_logger/formatter'

# see README
#
module SplunkLogger 
  class Logger
    extend SplunkLogger::Formatter
  
    class << self
      [:debug, :info, :warn, :error, :fatal].each do |meth|
        define_method(meth) { |error_code, *args|
          logger.send(meth, message(error_code, args))
        }
      end
  
      def trace(error_code, *backtrace)
        elements = ["TRACE", error_code] + message_data(backtrace)
        logger.error(elements.join("\n"))
      end
  
      def logger=(logger)
        @@logger = logger
      end
    
      def logger
        @@logger ||= if defined?(Rails) and defined?(Rails.logger)
          Rails.logger
        elsif defined?(::App::Logger)
          ::App::Logger # Rack convention
        else
          Logger.new(STDOUT)
        end
      end

    end
  end
end
