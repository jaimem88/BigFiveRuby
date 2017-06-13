#!/usr/bin/ruby -w
require 'pp'

require_relative './BigFiveResultsTextSerializer'
require_relative './BigFiveResultsPoster'

fileText = File.open("results.txt")
text = BigFiveResultsTextSerializer.new fileText

poster = BigFiveResultsPoster.new text.hash, 'jimmy.0.9.8@gmail.com'

poster.post

puts poster.response_code
puts poster.token