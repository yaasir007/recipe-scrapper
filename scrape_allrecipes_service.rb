require "open-uri"
require "nokogiri"
require_relative "recipe"

class ScrapeAllrecipesService
  def initialize(ingredient)
    @ingredient = ingredient
  end

  def call
    html = URI.open("https://www.allrecipes.com/search?q=#{@ingredient}").read
    # 1. Parse HTML
    doc = Nokogiri::HTML(html, nil, "utf-8")
    results = []
    # 2. Search the Nokogiri document by identifying the cards
    doc.search(".mntl-card-list-items.card").each do |element|
      # 3 Go through actual recipes and not blog articles - recipes are the cards with a rating
      unless element.search(".recipe-card-meta__rating-count-number").empty?
        # 4. Create recipe and store it in results
      name = element.search(".card__title-text").text.strip
      details_url = element.attribute("href").value
      details_doc = Nokogiri::HTML(URI.open(details_url).read, nil, "utf-8")
      description = details_doc.search("h2").first.text.strip
      rating = details_doc.search(".mntl-recipe-review-bar__rating").text.strip
      # prep_time = details_doc.search(".mntl-recipe-details__value").first.text.strip
      prep_time = (details_doc.search(".mntl-recipe-details__value").empty?) ? "No Prep Time" : details_doc.search(".mntl-recipe-details__value").first.text.strip
      # details_doc.search(".mntl-recipe-details__item").each do |prep_details|
      #   prep_time += prep_details.search(".mntl-recipe-details__value").first.text.strip
      # end
      # 6. Create a recipe instance and append it to our results array.
      results << Recipe.new(name, description, rating, prep_time)
      end
    end
    # 7. Select the first 5 recipes at the end when we're sure we have built recipes instances (no articles)
    results.first(5)
  end
end
