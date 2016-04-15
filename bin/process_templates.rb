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
  opts.on("-rREGION", "--aws_region=REGION", "AWS region where the templates bucket resides") do |region|
    options[:region] = region
  end
  opts.on("-bBUCKET", "--bucket_name=BUCKET", "Name of the S3 templates bucket") do |bucket|
    options[:bucket] = bucket
  end
end.parse!

Dir.glob(File.join(options[:directory], '*.json')) do |filename|
  content = File.read(filename)
  processed_content = content.gsub(/%TEMPLATE_VERSION%/, options[:version])
  File.open(filename, "w") { |file| file.puts processed_content }
  puts "https://s3-" + options[:region] + ".amazonaws.com/" + options[:bucket] + "/" + options[:version] + "/" + File.basename(filename)
end
