# Controller
# The controller will gather data from the cookbook to hand them over to the view.
# It will also ask the view for information to create new recipes.
# Here are the methods to implement:

require_relative 'cookbook'
require_relative 'view'
require_relative 'recipe_scrapper'
require 'byebug'

class Controller
  # initialize(cookbook) takes an instance of the Cookbook as an argument.
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  # list all the recipes
  def list
    recipes = @cookbook.all
    # byebug
    @view.display_recipes(recipes)
  end

  def consult
    recipes = @cookbook.all
    index = @view.ask_user_for_index(recipes)
    recipe = @cookbook.all[index]
    @view.consult_recipe(recipe)
  end

  def mark_as_read
    recipes = @cookbook.all
    index = @view.ask_user_for_index(recipes)
    recipe = @cookbook.all[index]
    recipe.mark_as_read
    @cookbook.update
  end

  # create a new recipe
  def create
    name = @view.ask_user_for_info("name")
    description = @view.ask_user_for_info("description")
    prep_time = @view.ask_user_for_attribute("prep_time")
    difficulty = @view.ask_user_for_attribute("difficulty")
    recipe = Recipe.new(name: name, description: description, prep_time: prep_time, difficulty: difficulty)
    @cookbook.add_recipe(recipe)
  end

  # destroy an existing recipe
  def destroy
    # Display list with indices
    recipes = @cookbook.all
    # Ask user for index
    index = @view.ask_user_for_index(recipes)
    # Remove from cookbook
    @cookbook.remove_recipe(index - 1)
  end

  def import
    scrapping_list
    # Ask user for index choice
    index = @view.ask_user_for_online_index(@scrapped_recipes)
    # Create a recipe object
    imported_recipe = Recipe.new(@scrapped_recipes[index - 1])
    # Import that recipe's name, description, prep_time, difficulty in the cookbook
    @view.telling_user_import_in_course(imported_recipe.name)
    @cookbook.add_recipe(imported_recipe)
  end

  private

  def scrapping_list
    # Ask user for query keyword
    query = @view.ask_user_for_attribute("query")
    # Return list of 5 first recipes'name
    scrapper = RecipeScrapper.new(query)
    scrapper.perform
    @scrapped_recipes = scrapper.recipes
  end

  def display_recipes
    # Fetch recipes from cookbook
    recipes = @cookbook.all
    # Send them to view for display
    @view.display_recipes(recipes)
  end
end
