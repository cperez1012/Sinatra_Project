class UsersController < ApplicationController

  # render login form
  get "/login" do
    erb :'users/login'
  end

  post '/login' do
    # binding.pry
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:message] = "Welcome back #{user.username}"
      redirect to "/users/#{user.id}"
    else
      flash[:error] = "Your credentials were invalid. Try again!"
      redirect to '/login'
    end
  end

  # SIGN UP
  # get sign up route that renders signup form
  get '/signup' do
    #render my sign form
    erb :'users/signup'
  end

  post '/users' do
    # binding.pry
    if params[:username].empty? || params[:password].empty? || params[:email].empty? || params[:confirm_password].empty?
      redirect to '/signup'
      # binding.pry
    elsif params[:password] != params[:confirm_password]
      flash[:error] = "Your credentials were invalid. Try again!"
    else
      user = User.create(username: params[:username], password: params[:password], email: params[:email])
      session[:user_id] = @user.id
      redirect to '/users/#{@user.id}'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      # binding.pry
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
