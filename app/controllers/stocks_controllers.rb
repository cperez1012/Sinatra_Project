class StocksController < ApplicationController

  get '/stocks' do
    if logged_in?
      @stocks = Stock.all
      redirect to "/stocks/show"
    else
      erb :"users/login"
    end
  end

  get '/stocks/new' do
    if logged_in?
      erb :"stocks/new"
    else
      redirect to '/index'
    end
  end

  post '/stocks' do
    @stock = Stock.new(price: params[:price], number_of_stocks: params[:number_of_stocks], institution_id: params[:institution_id])
    if @stock.save
    flash[:message] = "Stock Added by #{@user.username}!"
    session[:user_id] = @user.id

    redirect to "/institutions/#{@user.slug}"
    end
  end

  patch '/stocks/:id' do
    @stock = Stock.find(params[:id])
    @stock.update(price: params[:price], number_of_stocks: params[:number_of_stocks], institution_id: params[:institution_id])
    redirect "/stocks/#{@stock.id}"
  end


end
