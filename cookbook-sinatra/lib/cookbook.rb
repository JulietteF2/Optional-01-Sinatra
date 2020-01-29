# MODEL - Repository / Database
# In the context of this challenge, the repository stores the recipes added by the user.
# In other words, it is the cookbook.
# Lets name the class Cookbook to write explicit and meaningful code,
# but keep in mind that its the repository from this mornings diagram!

# Implement the Cookbook class with 4 methods:
require 'csv'
require_relative 'recipe'

class Cookbook
  # initialize(csv_file_path) which loads existing Recipe from the CSV
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []

    CSV.foreach(csv_file_path) do |row|
      recipe = Recipe.new(name: row[0], description: row[1], prep_time: row[2], difficulty: row[3], read: row[4])
      @recipes << recipe
    end
  end

  # all which returns all the recipes
  def all
    @recipes
  end

  # add_recipe(recipe) which adds a new recipe to the cookbook
  def add_recipe(recipe)
    @recipes << recipe
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recip|
        csv << [recip.name, recip.description, recip.prep_time, recip.difficulty, recip.read]
      end
    end
  end

  def update
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recip|
        csv << [recip.name, recip.description, recip.prep_time, recip.difficulty, recip.read]
      end
    end
  end

  # remove_recipe(recipe_index) which removes a recipe from the cookbook.
  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    CSV.open(@csv_file_path, 'w') do |csv|
      @recipes.each do |recip|
        csv << [recip.name, recip.description, recip.prep_time, recip.difficulty, recip.read]
      end
    end
  end
end
