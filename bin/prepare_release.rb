#!/usr/bin/ruby

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.on("-vVERSION", "--template_version=VERSION", "Template version") do |version|
    options[:version] = version
  end
  opts.on("-dDIRECTORY", "--templates_directory=DIRECTORY", "Templates directory") do |directory|
    options[:directory] = directory
  end
end.parse!

Dir.glob(File.join(options[:directory], '*.json')) do |filename|
  content = File.read(filename)
  processed_content = content.gsub(/%TEMPLATE_VERSION%/, options[:version])
  File.open(filename, "w") { |file| file.puts processed_content }
end
