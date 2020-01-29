require 'open-uri'
require 'nokogiri'
require 'byebug'

BASE_URL = "https://www.goodreads.com/"
term = "fiction"
url = BASE_URL + "search?query=#{term}"

doc = open(url).read
page = Nokogiri::HTML.parse(doc)
table = page.search("table").first
rows = table.search("tr")

books = []
books = rows.map do |book|
  cover = book.search("td:first a").attr("href").value
  title = book.search("span[itemprop='name']").first.text
  author = book.search("span[itemprop='name']")[1].text
  # byebug
  rating = book.search("span.greyText")[1]&.text&.strip.to_f
  {
    cover: cover,
    title: title,
    author: author,
    rating: rating
  }
  # byebug
end

books.each_with_index do |book, index|
  puts "#{index + 1}) #{book[:title]} by #{book[:author]} | #{book[:rating]}"
end

#puts books
puts "Finished"
