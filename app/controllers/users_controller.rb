class UsersController < ApplicationController

  get '/signup' do
    if logged_in?

      @user = current_user
      redirect to "/users/#{@user.slug}"
    else

      erb :'users/signup'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if @user.save
        puts "User successfully saved"
      flash[:message] = "Welcome, #{@user.username}!"
      session[:user_id] = @user.id

      redirect to "/users/#{@user.slug}"
    elsif User.find_by(email: params[:email])
      puts "Signup email is already taken"
      flash[:error] = "Signup email is already taken"
      redirect to '/signup'
    elsif User.find_by_slug(@user.slug)
      puts "Username is already taken"
      flash[:error] = "Username is already taken"
      redirect to '/signup'
    else
      puts "Your credentials were invalid. Try again!"
      flash[:error] = "Your credentials were invalid. Try again!"
      redirect to '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect to "/users/#{current_user.slug}"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:message] = "Welcome back #{@user.username}"
      redirect to "/users/#{current_user.slug}"
    else
      flash[:error] = "Your credentials were invalid. Try again!"
      redirect to "/login"
    end
  end
  # LOG OUT
# get logout that clears the session hash
  get '/logout' do
  #binding.pry
    session.clear if logged_in?
  #binding.pry
  # redirect to home/landing page
    redirect '/'
  end

  get '/users/' do
    if logged_in? && current_user
      erb :'users/show'
    else
      redirect to '/'
    end
  end

  post '/users' do
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  end


  get '/users/:slug' do
    if logged_in? && current_user.slug == params[:slug]
      # User.find_by_slug(@user.slug)
      erb :'users/show'
    else
      flash[:error] = "User not found!"
      redirect to "/"
    end
  end

end
