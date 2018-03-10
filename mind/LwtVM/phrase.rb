require 'nokogiri'
require 'open-uri'

term = "Kim+Kardashian+Marriage"
url = "http://www.google.com/search?num=100&hl=en&q=" + term
doc = Nokogiri::HTML(open(url))

n = rand(100)
doc.search('h3 a').each_with_index do |phrase, index|
  puts phrase.inner_text if index == n
end
