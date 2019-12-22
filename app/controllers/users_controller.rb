class UsersController < ApplicationController

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect to "/users/#{user.id}"
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:message] = "Welcome back #{user.username}"
      redirect "/users/#{user.id}"
    else
      flash[:error] = "Your credentials were invalid. Try again!"
      redirect to '/login'
    end
  end

  get "/users/:id" do
    # find the user
    user = User.find_by(id: params[:id])
    erb :'/users/show'
  end

  get '/show' do
    erb :'users/show'
  end

end
