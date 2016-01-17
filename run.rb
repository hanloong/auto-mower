#!/usr/bin/ruby

require_relative 'lib/mower'
require_relative 'lib/lawn'
require_relative 'lib/parser'
require 'pry'

if ARGV.count != 1
  'Please pass in path to input file as argument'
  exit
end

file = File.open(ARGV.first)

if file.nil?
  puts "Unable to open file"
  exit
end

parser = Parser.new file.read
lawn = Lawn.new parser.lawn_size.merge(mowers: parser.mowers)

lawn.mow!
puts lawn.output.join("\n")
