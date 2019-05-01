require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

before do
  @title = "User Management Project"
  @file = YAML.load(File.read("data/users.yaml"))
  @users = @file
  @user1, @user2, @user3 = @file.to_a
  count_users_and_interests
end

helpers do
	def user_links(sym)
    @users.to_a.reject {|arr| arr[0] == sym}.map {|array| array[0]}
  end

  def count_users_and_interests
    @user_count = @users.size
    @interests_count = @file.map {|k,v| v[:interests]}.flatten.uniq.size
  end
end

get "/" do
  #redirect "/users"
  location = "/users"
end

get "/users" do
  erb(:users)
end

get "/:user_name" do
  @title = params[:user_name]
	@user_name = params[:user_name].to_sym
  @email = @users[@user_name][:email]
  @interests = @users[@user_name][:interests]
	@links = user_links(@user_name)
  
	erb(:user)
end




