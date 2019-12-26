require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    #enables the sessions hash
    enable :sessions
    #sets session secret for an extra layer of security
    set :session_secret, "cowabunga"
    # register the sinatra flash/gem/functionality
    register Sinatra::Flash
  end

  get "/" do
    if logged_in?
      redirect "users/#{current_user.id}"
    else
      erb :index
    end
  end


  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end

    def authorized_to_edit?
      @user == current_user
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:error] = "You must be logged in in to view that page."
        redirect to "/"
      end
    end

    def redirect_if_logged_in
      if logged_in?
        flash[:message] = "You are already logged in. Welcome back #{current_user.username}!"
        redirect to "/"
      end
    end
  end
end
