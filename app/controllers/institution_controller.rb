class InstitutionsController < ApplicationController

  get "/institutions" do
    if logged_in?
      redirect to "/institutions/show"
    else
      erb :"users/login"
    end
  end

  get "/institutions/new" do
    if !logged_in?
      erb :"/institutions/new"
    end
  end

  post "/institutions" do
    if !logged_in?
      flash[:error] = "You must be logged in in to view that page."
      redirect to "/"
    end
    session[:user_id] = @user.id
      @institution = current_user.institutions.new(params[:institution])
      if @institution.save
        flash[:message] = "Institution Successfully Created. ADD Details Below:"
        redirect to "/institutions/#{@user.id}"
      else
        flash[:error] = "Institution Creation Failure: #{@institution.errors.full_messages.to_sentence}"
        redirect '/institutions/new'
      end
  end

  get "/institutions/:id" do
    if !logged_in?
      flash[:error] = "You must be logged in in to view that page."
      redirect to "/"
    end
    session[:institution_id] = params[:id]
    @institution = Institution.find(session[:user_id])
    if @institution.share_status == true
      erb :'/institutions/show'
    else
      if @institution.user == current_user
        erb :'/institutions/show'
      else
        flash[:error] = "Your are Not Authorized to View that Private Institution!"
        redirect to "/"
      end
    end
  end

  get "/institutions/:id/edit" do
    if !logged_in?
    @institution = Institution.find(params[:id])
      if @institution.user == current_user
        erb :'institutions/edit'
      else
        flash[:error] = "You're Not Authorized to Edit that Workout!"
        redirect to "/"
      end
    end
  end

  patch "/institutions/:id" do
    if !logged_in?
      flash[:error] = "You must be logged in in to view that page."
      redirect to "/"
    end
    @institution = Institution.find(params[:id])
    not_authorized_redirect
      if @institution.update(params[:institution])
        flash[:message] = "Institution Successfully Edited."
        redirect to "/institutions/#{@institution.id}"
      else
      flash[:error] = "Institution Edit Failure: #{@institution.errors.full_messages.to_sentence}"
      redirect to "/institutions/#{@institution.id}"
      end
  end

  delete "/institutions/:id" do
    if !logged_in?
      flash[:error] = "You must be logged in in to view that page."
      redirect to "/"
    end
    @institution= Institutions.find(params[:id])
    if @institution.user == current_user
      @institution.destroy
      flash[:message] = "Institution Successfully Deleted"
      redirect to "/users/#{current_user.slug}"
    else
      flash[:error] = "You're Not Authorized to Delete This Institution!"
      redirect to "/institutions/#{@institution.id}"
    end
  end
end
