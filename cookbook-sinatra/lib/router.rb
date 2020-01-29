class Router
  def initialize(controller)
    @controller = controller
    @running    = true
  end

  def run
    puts "-- My Cookbook --"

    while @running
      display_tasks
      action = gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then @controller.list
    when 2 then @controller.consult
    when 3 then @controller.mark_as_read
    when 4 then @controller.create
    when 5 then @controller.destroy
    when 6 then @controller.import
    when 7 then stop
    else puts "Please press 1, 2, 3, 4, 5, 6 or 7"
    end
  end

  def stop
    @running = false
  end

  def display_tasks
    puts ""
    puts "What do you want to do?"
    puts "1 - List all recipes"
    puts "2 - Consult a recipe"
    puts "3 - Mark as read"
    puts "4 - Create a new recipe"
    puts "5 - Destroy a recipe"
    puts "6 - Import a recipe from the internet"
    puts "7 - Stop and exit the program"
  end
end
