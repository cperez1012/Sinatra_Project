class InvesthubController < ApplicationController

  get '/investhub/new' do
    erb :'investhub/new'
  end

  post '/investhub/new' do
    if logged_in?
      session[:user_id] = user.id
      @investments = Investment.all
      @companys = Company.all
      @user_id = user_id
      @company_id = company_id
      erb :'investhub/investments'
    else
      # show the error message
      flash[:error] = "You must be logged in to add an investment!"
      redirect "/"
    end
  end
  #
  # post '/investhub/show_investments' do
  #
  #   end
  #
  # end

   patch '/posts/:id' do
     @user = User.find(params[:id])
     @user.update(name: params[:name], image_url: params[:image_url], year_founded: params[:year_founded], industry: params[:year_founded], description: params[:description])
     redirect "/investhub/#{@user.id}"
   end
end
