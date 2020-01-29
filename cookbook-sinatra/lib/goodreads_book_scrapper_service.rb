# Scrapping with OOP
require 'open-uri'
require 'nokogiri'
require 'byebug'

class Book
  def initialize(attributes = {})
    @cover = attributes[:cover]
    @title = attributes[:title]
    @author = attributes[:author]
    @rating = attributes[:rating] || 0.0
  end

  def to_s
    "#{@title} by #{@author} | #{@rating} rating"
  end
end

class GoodreadsBookScrapperService
  BASE_URL = "https://www.goodreads.com/"
  attr_reader :books

  def initialize(term)
    @url = BASE_URL + "search?query=#{term}"
    @books = []
  end

  def perform
    build_books
    self
  end


  private

  def build_books
    @books = rows.map { |book| build_book(book) }
  end

  def build_book(book)
    cover = book.search("td:first a").attr("href").value
    title = book.search("span[itemprop='name']").first.text
    author = book.search("span[itemprop='name']")[1].text
    rating = book.search("span.greyText")[1]&.text&.strip.to_f
    attributes = {
      cover: cover,
      title: title,
      author: author,
      rating: rating
    }
    Book.new(attributes)
  end

  def doc
    @doc ||= open(@url).read
  end

  def page
    @page ||= Nokogiri::HTML.parse(doc)
  end

  def table
    @table ||= page.search("table").first
  end

  def rows
    @rows ||= table.search("tr")
  end
end

scrapper = GoodreadsBookScrapperService.new("fiction").perform
books = scrapper.books

books.each_with_index do |book, index|
  puts "#{index + 1}) #{book.to_s}"
end

#puts books
puts "Finished"
