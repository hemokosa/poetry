# rdoc -S -N -c UTF-8 -t "Post Internet Genrative Poetry by Akihiro Kubota, for Source Code Poetry 2018" -m Post_Internet_Generative_Poetry Kim_Kardashian’s_Marriage.rb
require 'nokogiri'
require 'open-uri'

# The title of Riviere’s book is misleading: the text inside was not, as you might have guessed, scraped from Kim Kardashian’s social-media presence or from gossip sites; in fact, it has nothing to do with her or her wedding at all, really.
class Post_Internet_Generative_Poetry

  # - "{Kim Kardashian's Marriage}[https://samriviere.com/index.php?/alone/kim-kardashians-marriage/]", Faber & Faber, 2015.
  Sam_Riviere = 'Poet'

  # Instead, her previous union with the basketballer Kris Humphries, which lasted for 72 days, is made the collection’s silent scaffold. There are 72 poems arranged in chapters named after Kim’s daily cosmetic rites: “Primer”, “Contour”, “Highlight”, “Powder”, “Blend”, “Shadow”, “Liner”, “Gloss”.
  attr_reader :Kims_Daily_Cosmetic_Rites

  # Instead, Riviere used the duration of Kardashian’s marriage to Kris Humphries—seventy-two days—as a constraint to determine how many poems the book would contain.
  def initialize()
    @Kims_Daily_Cosmetic_Rites = ["Primer", "Contour", "Highlight", "Powder", "Blend", "Shadow", "Liner", "Gloss"]
  end

  # Through an elaborate process of cannibalizing and recombining chapter headings from his previous books, Riviere has come up with a series of keywords upon which his Web searches are based.
  attr_accessor :url

  # And the whole book is similarly deceptive: what appears to be a series of semi-confessional lyric poems are all mathematically based on Web searches.
  def generate()
    for chapter in @Kims_Daily_Cosmetic_Rites do
      url = "http://www.google.com/search?num=10&hl=en&q=Kim+Kardashian+" + chapter

      # After throwing them into Google, he accepts the first ten results from each search and then crafts them into stanzas. His book is entirely unoriginal: not a single word of his own is added.
      search = open(url)
      verse = Nokogiri::HTML.parse(search)
      rank = rand(10)
      verse.search('h3 a').each_with_index do |rhyme, index|
        puts rhyme.inner_text if index == rank
      end
    end
  end

  # This strange collection feels a long way from a wedding song. Nowhere does it mention Kim Kardashian’s lavish marriage to the musician Kanye West in Florence last May.
  module Document

    # - "{Kim Kardashian’s Marriage by Sam Riviere, review: 'great wit'}[ttps://www.telegraph.co.uk/culture/books/bookreviews/11451715/Kim-Kardashians-Marriage-by-Sam-Riviere.html]" by  Iona McLaren, March 06, 2015.
    # - "{Post-Internet Poetry Comes of Age}[https://www.newyorker.com/books/page-turner/post-internet-poetry-comes-of-age]" by Kenneth Goldsmith, March 10, 2015.
    def Reference()
    end
  end

end
Post_Internet_Generative_Poetry.new.generate
# Repository - https://github.com/hemokosa/poetry/tree/master/kkm
