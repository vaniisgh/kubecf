#!/usr/bin/env ruby

require 'pathname'

def publish(binary)
  puts "Publishing #{File.basename binary}..."
  # TODO: Implement publishing.
end

"{binaries}".split("{binaries_separator}").map do |file|
  Pathname(file)
end.each do |file|
  publish File.realpath(file)
end
