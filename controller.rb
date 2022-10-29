require_relative "view"
require_relative "recipe"
require_relative "scrape_allrecipes_service"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipe
  end

  def create
    name = @view.ask_for_recipe_name
    description = @view.ask_for_recipe_description
    rating = @view.ask_user_for_rating
    prep_time = @view.ask_user_for_prep_time
    recipe = Recipe.new(name, description, rating, prep_time)
    @cookbook.add_recipe(recipe)
    display_recipe
  end

  def destroy
    display_recipe
    recipe_index = @view.ask_user_for_index
    @cookbook.remove_recipe(recipe_index)
    display_recipe
  end

  def import
    # 1. Ask user for a keyword
    keyword = @view.ask_for_keyword
    @view.ask_user_to_wait
    # 2. using this keyword on line, scrape all recipe from web
    result = ScrapeAllrecipesService.new(keyword).call
    # 3 display result/all titles from the web
    @view.display(result)
    # 4. Ask for the recipe to import
    index = @view.ask_user_for_index
    # 5. Add to cookbook
    @cookbook.add_recipe(result[index])
    # 6. Display
    display_recipe
  end

  def mark_as_done
    #1. Display all recipes
    display_recipe
    #2. Ask user for index
    user_index = @view.ask_user_for_index
    #3. Mark as one and save in repo
    @cookbook.mark_recipe_as_done(user_index)
    #4. display recipe with status
    display_recipe
  end

  private

  def display_recipe
    recipes = @cookbook.all
    @view.display(recipes)
  end
end
