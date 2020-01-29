require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @usernames = ['ssaunier', 'Papillard']
  @recipes = ['ssaunier', 'Papillard']
  erb :index
end

get '/list' do
  @usernames = ['ssaunier', 'Papillard']
  @recipes = ['Pizza', 'Tiramisu']
  erb :list
end

get '/team/:username' do
  puts params[:username]
  "The username is #{params[:username]}"
end
