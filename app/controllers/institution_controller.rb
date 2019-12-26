class InstitutionsController < ApplicationController

  get "/institutions" do
    if logged_in?
      @institutions = Institution.all
      redirect to "/institutions/show"
    else
      erb :"users/login"
    end
  end

  get "/institutions" do
    if logged_in?
      erb :"/institutions/show"
    else
      redirect to "/index"
    end
  end

  get "/institutions/new" do

    if logged_in?
      erb :"/institutions/new"
    else
      redirect to "/index"
    end
  end

  post "/institutions/new" do
    @institutions = Institution.new(name: params[:name], description: params[:description], year_founded: params[:year_founded], industry: params[:industry], image_url: params[:image_url], user_id: params[:user_id])
    if @institutions.save
        puts "User successfully saved institution"
      flash[:message] = "Institution Added by #{@user.username}!"
      session[:user_id] = @user.id

      redirect to "/institutions/#{@user.slug}"
    end
  end

  # get "/institutions/:id" do
  #   # @institution = Institution.find(params[:id])
  #   erb :"/institutions/show"
  # end

  patch '/institutions/:id' do
    @institution = Institution.find(params[:id])
    @institution.update(name: params[:name], description: params[:description], year_founded: params[:year_founded], industry: params[:industry], image_url: params[:image_url], user_id: params[:user_id])
    redirect "/posts/#{@post.id}"
  end
#   get "/institutions/new" do
#     if !logged_in?
#       erb :"/institutions/new"
#     end
#   end
#
#   post "/institutions" do
#     if !logged_in?
#       flash[:error] = "You must be logged in in to view that page."
#       redirect to "/"
#     else
#       session[:user_id] = @user.id
#       @institutions = current_user.Institution.new(params)
#       if @institution.save
#         flash[:message] = "Institution Successfully Created. ADD Details Below:"
#         redirect to "/institutions/#{@user.id}"
#       else
#         flash[:error] = "Institution Creation Failure: #{@institution.errors.full_messages.to_sentence}"
#         redirect '/institutions/new'
#       end
#     end
#   end
#
#   get "/institutions/:id" do
#     if !logged_in?
#       flash[:error] = "You must be logged in in to view that page."
#       redirect to "/"
#     end
#     session[:institution_id] = params[:id]
#     @institutions = Institution.find(session[:user_id])
#       if @institution.user == current_user
#         erb :'/institutions/show'
#       else
#         flash[:error] = "Your are Not Authorized to View that Private Institution!"
#         redirect to "/"
#       end
#     end
#   end
#
#   get "/institutions/:id/edit" do
#     if !logged_in?
#     @institution = Institution.find(params[:id])
#       if @institution.user == current_user
#         erb :'institutions/edit'
#       else
#         flash[:error] = "You're Not Authorized to Edit that Workout!"
#         redirect to "/"
#       end
#     end
#   end
#
#   patch "/institutions/:id" do
#     if !logged_in?
#       flash[:error] = "You must be logged in in to view that page."
#       redirect to "/"
#     else
#       @institution = Institution.find(params[:id])
#       authorized_to_edit
#       if @institution.update(params[:institution])
#         flash[:message] = "Institution Successfully Edited."
#         redirect to "/institutions/#{@institution.id}"
#       else
#       flash[:error] = "Institution Edit Failure: #{@institution.errors.full_messages.to_sentence}"
#       redirect to "/institutions/#{@institution.id}"
#       end
#     end
#   end
#
#   delete "/institutions/:id" do
#     if !logged_in?
#       flash[:error] = "You must be logged in in to view that page."
#       redirect to "/"
#     end
#     @institution= Institutions.find(params[:id])
#     if @institution.user == current_user
#       @institution.destroy
#       flash[:message] = "Institution Successfully Deleted"
#       redirect to "/users/#{current_user.slug}"
#     else
#       flash[:error] = "You're Not Authorized to Delete This Institution!"
#       redirect to "/institutions/#{@institution.id}"
#     end
#   end
end
