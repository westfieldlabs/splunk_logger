module SplunkLogger 
  module Formatter

    KeyRegex = Regexp.new('\W')
  
    def message(error_code, hash)
      ([error_code] + to_pairs(message_data(hash))).join(" ")
    end

    protected # implementation of protected class methods thanks http://blog.jayfields.com/2006/11/ruby-protected-class-methods.html

    def message_data(args)
      (args[0].is_a?(Array) ? args.shift : args)
    end

    def to_pairs(hash)
      hash.map do |key, value|
        "#{key.to_s.gsub(KeyRegex, '_')}=\"#{value}\""
      end
    end

  end
end
