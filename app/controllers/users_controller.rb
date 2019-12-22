class UsersController < ApplicationController

  get '/users/:slug' do
    if logged_in? && current_user.slug == params[:slug]
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    else
      redirect to '/'
    end
  end

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    if user = User.create(username: params[:username], email: params[:email], password: params[:password], wallet: params[:wallet])
    session[:user_id] = user.id
    redirect to "users/show"
    else
      params[:password] != params[:confirm_password]
      flash[:error] = "Your credentials were invalid. Try again!"
      erb :'/signup'
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:message] = "Welcome back #{user.username}"
      redirect "users/#{user.username}/show"
    elsif user.id != session[:user_id]
      flash[:error] = "Please signup."
      redirect to '/signup'
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

  post '/users' do
    # will eventually need to add validations to confirm all inputs are filled out before creating user
    @user = User.create(username: params[:username], email: params[:email], password: params[:password], wallet: params[:wallet])
    # post sign up route to create user using params and add key/value pair to sessions hash
    session[:user_id] = @user.id
    # redirect to user profile
    redirect "/users/#{@user.id}"
  end

end
