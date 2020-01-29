require_relative 'cookbook'    # You need to create this file!
require_relative 'controller'  # You need to create this file!
require_relative 'router'

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)
controller = Controller.new(cookbook)

router = Router.new(controller)

# Start the app
router.run


# We give you the app.rb that requires the code to instantiate a Cookbook, Controller and start the app.
# The infinite loop is given in the Router because this is not part of MVC.
