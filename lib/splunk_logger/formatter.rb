module SplunkLogger 
  module Formatter

    KeyRegex = Regexp.new('\W')
  
    def message(error_code, *args)
      ([error_code] + to_pairs(message_data(args))).join(" ")
    end

    protected # implementation of protected class methods thanks http://blog.jayfields.com/2006/11/ruby-protected-class-methods.html

    def message_data(args)
      (args[0].is_a?(Array) ? args.shift : args)
    end

    def to_pairs(arr)
      (0...arr.size()).step(2).map { |e|
      "#{arr[e].to_s.gsub(KeyRegex, '_')}=\"#{arr[e+1]}\"" # underscore keys, quote values
      }
    end

  end
end
