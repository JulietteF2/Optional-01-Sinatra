# View
# The view is responsible for all the puts and gets of your code.
# Make sure you never have those words anywhere else! (except maybe for debugging)

class View
  def display_recipes(recipes)
    recipes.each_with_index do |recipe, index|
      if recipe.read?
        puts "#{index + 1}. [X] #{recipe.name} (#{recipe.prep_time})"
      else
        puts "#{index + 1}. [ ] #{recipe.name} (#{recipe.prep_time})"
      end
    end
  end

  def consult_recipe(recipe)
    puts recipe.name
    puts "#{recipe.prep_time} - #{recipe.difficulty}"
    puts recipe. description
  end

  def ask_user_for_online_index(recipes)
    display_result(recipes)
    puts "What is the index of your recipe?"
    gets.chomp.to_i - 1
  end

  def display_result(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe[:name]} (#{recipe[:prep_time]})"
    end
  end

  def ask_user_for_info(info)
    case info
    when "name"
      puts "What is the name of your recipe?"
      gets.chomp
    when "description"
      puts "Describe your recipe"
      gets.chomp
    end
  end

  def ask_user_for_attribute(attribute)
    case attribute
    when "prep_time"
      puts "How long does it take to prepare that recipe?"
      gets.chomp
    when "difficulty"
      puts "How difficult is that recipe?"
      gets.chomp
    when "query"
      puts "What ingredient would you like a recipe for?"
      gets.chomp
    end
  end

  def ask_user_for_index(recipes)
    display_recipes(recipes)
    puts "What is the index of your recipe?"
    gets.chomp.to_i - 1
  end

  def telling_user_import_in_course(recipe_name)
    puts "Importing #{recipe_name}"
  end
end
