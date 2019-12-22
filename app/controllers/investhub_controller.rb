class InvesthubController < ApplicationController
#
#   # use Rack::Flash
#
#   get '/:slug/tips' do
#     @user = User.find_with_slug(params[:slug])
#     if logged_in? && session[:user_id] == @user.id
#         erb :'/users/show'
#     else
#         redirect to "/login"
#     end
#   end
#
  get '/investhub/new' do
    if logged_in?
      erb :'investhub/new'
    else
      redirect '/login'
    end
  end
#
#   get '/investhub' do
#     @Companys = Company.all
#     erb :'investhub/show_investments'
#   end
#
#   post '/investhub' do
#     company = Company.new(name: params[:name], image_url: params[:image_url], year_founded: params[:year_founded], industry: params[:industry], description: params[:description], user_id: current_user.id)
#     if company.save
#       flash[:message] = "Created company successfully!"
#       redirect "/investhub/investments"
#     else
#       flash[:error] = "Company creation failed: #{investhub.errors.full_messages.to_sentence}"
#       redirect "/investhub/new"
#     end
#   end
#
#   post '/investhub/new' do
#     redirect to '/investhub/show_investments'
#   end
#
#   get '/investhub/show_investments' do
#     if logged_in?
#       erb :'/investhub/show_investments'
#     end
#   end
#
#   post '/investhub/show_investments' do
#     if params[:name].empty? || params[:image_url].empty? || params[:year_founded].empty? || params[:industry].empty? || params[:description].empty? || params[:user_id].empty?
#       redirect "/investhub/new"
#     else
#       redirect "/investhub/show_investments"
#     end
#   end
#
#   get '/investhub/:id' do
#     if !logged_in?
#       redirect "/login"
#     end
#     @investhub = Investhub.find(params[:id])
#     erb :'investhub/investments'
#   end
#
#   get '/investhub/:id/edit' do
#     if !logged_in?
#       redirect "/login"
#     end
#     @investhub = Investhub.find(params[:id])
#     erb :'investhub/edit_investments'
#   end
#
#   patch '/investhub/:id' do
#     if params[:name].empty? || params[:image_url].empty? || params[:year_founded].empty? || params[:industry].empty? || params[:description].empty? || params[:user_id].empty?
#       redirect "/investhub/#{params[:id]}/edit"
#     end
#     investhub = Investhub.find(params[:id])
#     investhub.update(name: params[:name], image_url: params[:image_url], year_founded: params[:year_founded], industry: params[:industry], description: params[:description], user_id: params[:user_id])
#     redirect "/investhub/#{investhub.id}"
#   end
#
#   delete '/investhub/:id' do
#     investhub = Investhub.find(params[:id])
#     if current_user.id != investhub.id
#       redirect '/investhub'
#     end
#     investhub.destroy
#   end
#
end
