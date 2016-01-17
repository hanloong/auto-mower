#!/usr/bin/ruby

require_relative 'lib/solver'

if ARGV.count != 1
  'Please pass in path to input file as argument'
  exit
end

file = File.open(ARGV.first)

if file.nil?
  puts "Unable to open file"
  exit
end

input = file.read
width, height, mowers_count = input.split(' ').map(&:to_i)
solver = Solver.new width: width, height: height, mowers_count: mowers_count

solver.solve.each do |path|
  puts "#{path[:start]}\n#{path[:path]}\n\n"
end
