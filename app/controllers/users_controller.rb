class UsersController < ApplicationController

  get '/users/:slug' do
    if logged_in? && current_user.slug == params[:slug]
      @user = User.find_by_slug(params[:slug])
      redirect to :'/users/show'
    end
  end

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty? ||params[:wallet].empty?
      redirect '/signup'
    end
      user = User.create(username: params[:username], email: params[:email], password: params[:password], wallet: params[:wallet])
      session[:user_id] = user.id
      redirect to "/show"
  end

  get '/login' do
    if logged_in?
      redirect to '/show'
    end
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username]).authenticate(params[:password])
    if user
      session[:user_id] = user.id
      flash[:message] = "Welcome back #{user.username}"
      redirect to "/show"
    else
      flash[:error] = "Your credentials were invalid. Try again!"
      redirect to '/login'
    end
  end

  get "/users/:id" do
    # find the user
    @user = User.find_by(id: params[:id])
    erb :"/users/show"
  end

  # LOG OUT
# get logout that clears the session hash
  get '/logout' do
  #binding.pry
    session.clear
  #binding.pry
  # redirect to home/landing page
    redirect '/login'
  end


  post '/users' do
    # will eventually need to add validations to confirm all inputs are filled out before creating user
    user = User.create(params)
    # post sign up route to create user using params and add key/value pair to sessions hash
    session[:user_id] = user.id
    # redirect to user profile
    redirect "/users/#{user.id}"
  end

end
