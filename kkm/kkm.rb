# The title of Riviere’s book is misleading: the text inside was not, as you might have guessed, scraped from Kim Kardashian’s social-media presence or from gossip sites; in fact, it has nothing to do with her or her wedding at all, really. Instead, Riviere used the duration of Kardashian’s marriage to Kris Humphries—seventy-two days—as a constraint to determine how many poems the book would contain. And the whole book is similarly deceptive: what appears to be a series of semi-confessional lyric poems are all mathematically based on Web searches. Through an elaborate process of cannibalizing and recombining chapter headings from his previous books, Riviere has come up with a series of keywords upon which his Web searches are based. After throwing them into Google, he accepts the first ten results from each search and then crafts them into stanzas. His book is entirely unoriginal: not a single word of his own is added.

# excerpted from "Post-Internet Poetry Comes of Age" by Kenneth Goldsmith, March 10, 2015
# https://www.newyorker.com/books/page-turner/post-internet-poetry-comes-of-age

# This strange collection feels a long way from a wedding song. Nowhere does it mention Kim Kardashian’s lavish marriage to the musician Kanye West in Florence last May. Instead, her previous union with the basketballer Kris Humphries, which lasted for 72 days, is made the collection’s silent scaffold. There are 72 poems arranged in chapters named after Kim’s daily cosmetic rites: “Primer”, “Contour”, “Highlight”, “Powder”, “Blend”, “Shadow”, “Liner”, “Gloss”.

# excerpted from "Kim Kardashian’s Marriage by Sam Riviere, review: 'great wit'" by  Iona McLaren, March 06, 2015
# https://www.telegraph.co.uk/culture/books/bookreviews/11451715/Kim-Kardashians-Marriage-by-Sam-Riviere.html

require 'nokogiri'
require 'open-uri'

kims_daily_cosmetic_rites = ["Primer", "Contour", "Highlight", "Powder", "Blend", "Shadow", "Liner", "Gloss"]
for chapter in kims_daily_cosmetic_rites do
  url = "http://www.google.com/search?num=10&hl=en&q=Kim+Kardashian+" + chapter
  page = open(url)
  search = Nokogiri::HTML page
  line = rand(10)
  search.search('h3 a').each_with_index do |phrase, index|
    puts phrase.inner_text if index == line
  end
end
