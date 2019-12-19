class InvesthubController < ApplicationController
  
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
    @investhub = Investhub.all
    erb :'investhub/investments'
  end

  post '/investhub' do
    if params[:content].empty?
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
    if params[:content].empty?
      redirect "/investhub/#{params[:id]}/edit"
    end
    investhub = Investhub.find(params[:id])
    investhub.update(content: params[:content])
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