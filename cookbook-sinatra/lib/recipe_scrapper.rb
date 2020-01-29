# Scraping recipes
require 'open-uri'
require 'nokogiri'
require 'byebug'

class RecipeScrapper
  BASE_URL = "https://www.bbcgoodfood.com/search/recipes?query="
  attr_accessor :recipes

  def initialize(query)
    @url = BASE_URL + query
    @recipes = []
  end

  def perform
    articles.map do |article|
      name = article.search(".teaser-item__title").text.strip
      description = article.search(".teaser-item__text-content").text
      prep_time = article.search(".teaser-item__info-item--total-time").text.strip
      difficulty = article.search(".teaser-item__info-item--skill-level").text.strip
      recipes << { name: name, description: description, prep_time: prep_time, difficulty: difficulty }
      recipes.slice!(5)
    end
  end

  private

  def doc
    @doc ||= open(@url).read
  end

  def page
    @page ||= Nokogiri::HTML.parse(doc)
  end

  def results
    @results ||= page.search(".search-content")
  end

  def articles
    @articles ||= results.search("article")
  end
end
