class InvestmentsController < ApplicationController

  get '/investments' do
    if logged_in? && current_user
      erb :'investments/new'
    else
      redirect to '/'
    end
  end

  get '/investments/:id' do
    @investment = Investment.find(params[:id])
    erb :"/investments/show"
  end

  post "/investments" do
    @investment = Investment.new(user_id: params[:user_id], institution_id: params[:institution_id])
    if investment.save
      redirect to "/investments/#{@investment.id}"
    else
      redirect to "/investments/new"
    end
  end
end
