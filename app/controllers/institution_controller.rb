class InstitutionsController < ApplicationController
  #
  # get '/investhub' do
  #   if logged_in?
  #     @user = current_user
  #     @investments = Investment.all
  #     @stocks = Stock.all
  #     @user_id = user_id
  #     erb :'investhub/investments'
  # end

  # post '/investhub' do
  #   if params[:name].empty?
  #     redirect to '/investhub/new'
  #   end
  # end
  #
  post "/investhub/new" do
  # recieve the params that the user input in the create new post form
  institution = Institution.new(name: params[:name], image_url: params[:image_url], industry: params[:industry], year_founded: params[:year_founded], description: params[:description], user_id: current_user.id)
    if institution.save
  # ^ if valid input — .save triggers our validation
  #if params[:title] != "" && params[:description] != "" && params[:image_url] != ""
    # show post creation success message
      flash[:message] = "Created Institution successfully!"
    # redirect to the post show page
      redirect "/investhub/#{institution.id}"
    else
    # show post creation error message
      flash[:error] = "Institution creation failed."
      redirect "/investhub/new"
    end
  end

  get '/investhub/new' do
    if logged_in?
      erb :'investhub/new'
    else
      redirect to "/users/#{current_user.slug}"
    end
  end

  get '/investhub/:id' do
  # find the post
  @user = current_user
  @institution = Institution.all
  @institution = Institution.find(params[:id])

  erb :"/investhub/show"
end
  # #
  # post '/investhub/new' do
  #   if logged_in?
  #     session[:user_id] = user.id
  #     @investments = Investment.all
  #     @companys = Company.all
  #     @user_id = user_id
  #     @company_id = company_id
  #     erb :'investhub/investments'
  #   else
  #     # show the error message
  #     flash[:error] = "You must be logged in to add an investment!"
  #     redirect "/"
  #   end
  # end
  # #
  # # post '/investhub/show_investments' do
  # #
  # #   end
  # #
  # # end
  #
  #  patch '/posts/:id' do
  #    @user = User.find(params[:id])
  #    @user.update(name: params[:name], image_url: params[:image_url], year_founded: params[:year_founded], industry: params[:year_founded], description: params[:description])
  #    redirect "/investhub/#{@user.id}"
  #  end
end
