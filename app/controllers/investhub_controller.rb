class InvesthubController < ApplicationController

  # use Rack::Flash

  get '/:slug/tips' do
    @user = User.find_with_slug(params[:slug])
    if logged_in? && session[:user_id] == @user.id
        erb :'/users/show'
    else
        redirect to "/login"
    end
  end

  get '/investhub/new' do
    if logged_in?
      erb :'investhub/new'
    else
      redirect '/login'
    end
  end

  get '/investhub' do
    if !logged_in?
      redirect '/login'
    end
    @user = current_user
    @Companys = Company.all
    erb :'/show_investments'
  end

  post '/investhub' do
    if params[:name].empty? || params[:image_url].empty? || params[:year_founded].empty? || params[:industry].empty? || params[:description].empty? || params[:user_id].empty?
      redirect "/investhub/new"
    end
    investhub = Investhub.create(params)
    investhub.user = current_user
    investhub.save
    redirect "/investhub/#{investment.id}"
  end

  get '/investhub/:id' do
    if !logged_in?
      redirect "/login"
    end
    @investhub = Investhub.find(params[:id])
    erb :'investhub/show_investments'
  end

  get '/investhub/:id/edit' do
    if !logged_in?
      redirect "/login"
    end
    @investhub = Investhub.find(params[:id])
    erb :'investhub/edit_investments'
  end

  patch '/investhub/:id' do
    if params[:name].empty? || params[:image_url].empty? || params[:year_founded].empty? || params[:industry].empty? || params[:description].empty? || params[:user_id].empty?
      redirect "/investhub/#{params[:id]}/edit"
    end
    investhub = Investhub.find(params[:id])
    investhub.update(name: params[:name], image_url: params[:image_url], year_founded: params[:year_founded], industry: params[:industry], description: params[:description], user_id: params[:user_id])
    redirect "/investhub/#{investhub.id}"
  end

  delete '/investhub/:id' do
    investhub = Investhub.find(params[:id])
    if current_user.id != investhub.id
      redirect '/investhub'
    end
    investhub.destroy
  end

end
