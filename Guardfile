guard 'rspec', :cli => "--colour --format nested" do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/(.+)\.rb$})     { |m| "spec/#{m[1]}/*_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end
