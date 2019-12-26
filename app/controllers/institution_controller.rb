class InstitutionsController < ApplicationController

  get "/institutions/new" do
    redirect_if_not_logged_in
    erb :"/institutions/new"
  end

  post "/institutions" do
    redirect_if_not_logged_in
      @institutions = current_user.institutions.new(params[:institution])
      if @institution.save
        flash[:message] = "Institution Successfully Created. ADD Details Below:"
        redirect to "/institutions/#{@institution.id}"
      else
        flash[:error] = "Institution Creation Failure: #{@institution.errors.full_messages.to_sentence}"
        redirect '/institutions/new'
      end
  end

  get "/institutions/:id" do
    redirect_if_not_logged_in
    session[:institution_id] = params[:id]
    @institution = Institution.find(session[:institution_id])
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
    redirect_if_not_logged_in
    @institution = Institution.find(params[:id])
    if @institution.user == current_user
      erb :'institutions/edit'
    else
      flash[:error] = "You're Not Authorized to Edit that Workout!"
      redirect to "/"
    end
  end

  patch "/institutions/:id" do
    redirect_if_not_logged_in
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
    redirect_if_not_logged_in
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
