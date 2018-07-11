require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require 'yaml'

before do
  @users = YAML.load_file('users.yml')
  @user_count = @users.count
  @interest_count = @users.map { |user, info| info[:interests].count  }.sum
end

not_found do
  redirect "/"
end

get "/" do
  redirect "/users"
end

get "/users" do
  @title = "Users"

  erb :users
end

get "/user/:name" do
  name = params[:name]

  @title = "User | " + name.capitalize

  @user = @users[name.to_sym]
  @user[:name] = name

  @other_users = @users.clone
  @other_users.delete(name.to_sym)

  erb :user
end
