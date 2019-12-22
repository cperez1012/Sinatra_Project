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

  post '/signup' do
  # binding.pry
    if params[:username] == "" || params[:password] == "" || params[:email] == "" || params[:confirm_password] == ""
      redirect to '/signup'
    # binding.pry
    elsif params[:password] != params[:confirm_password]
      flash[:error] = "Your credentials were invalid. Try again!"
    else
      user = User.create(username: params[:username], password: params[:password], email: params[:email])
      session[:user_id] = user.id
      redirect to '/investhub'
    end
  end

  # post '/users' do
  #   # will eventually need to add validations to confirm all inputs are filled out before creating user
  #   @user = User.create(params)
  #   # post sign up route to create user using params and add key/value pair to sessions hash
  #   session[:user_id] = @user.id
  #   # redirect to user profile
  #   redirect "/users/#{@user.id}"
  # end

  get '/logout' do
    if logged_in?
      session.clear
      # binding.pry
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/users/:slug' do
    if logged_in? && current_user.slug == params[:slug]
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    else
      redirect to '/investhub'
    end
  end

end
