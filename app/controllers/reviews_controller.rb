class ReviewsController < ApplicationController

get "/reviews" do
    @reviews = Review.all
    erb :"reviews/index"
end 

get "/reviews/new" do 
    erb :"reviews/new"
end

post "/reviews" do
    @review = Review.new(:title => params[:title], :content => params[:content], :user_id => params[:user_id], :created_at => "#{Time.now}", :updated_at => "#{Time.now}")
    if @review.save
        redirect "/reviews/#{@review.id}"
    else
        redirect "/reviews/new"
    end 
end 

get "/reviews/:id" do
    @review = Review.find(params[:id])
    erb :"reviews/display"
end

patch "/reviews/:id" do
  @review = Review.find(params[:id])
  if params[:content].empty?
    redirect "/reviews/#{@review.id}/edit"
  end
  @review.update(:title => params[:title], :content => params[:content])
  @review.save
  redirect "/reviews/#{@review.id}"
end

get "/reviews/:id/edit" do
    if !logged_in?
      redirect "/login"
    end 
    @review = Review.find(params[:id])
    if @review && @review.user.id == session[:user_id]
      erb :'reviews/edit'
    else
      redirect '/login'
    end
  end

  delete '/reviews/:id/delete' do
    if !logged_in?
      redirect "/login"
    end 
    @review = Review.find_by_id(params[:id])
    if @review && @review.user == current_user
      @review.delete
    end
    redirect to '/reviews'
  end

end 