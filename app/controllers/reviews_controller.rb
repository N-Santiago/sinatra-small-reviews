class ReviewsController < ApplicationController

get "/reviews" do
    @reviews = Review.all
    erb :"reviews/index"
end 

get "/reviews/new" do 
    erb :"reviews/new"
end

post "/reviews" do
    @review = Review.new(:title => params[:title], :content => params[:content], :user_id => params[:user_id], :category_id => params[:category_id], :created_at => "#{Time.now}", :updated_at => "#{Time.now}")
    if @review.save
        redirect "/reviews/#{@review.id}"
    else
        redirect "/reviews/new"
    end 
end 

get "/reviews/:id" do
  set_review
  if @review
    erb :"reviews/display"
  else 
    redirect "/reviews"
  end 
end

patch "/reviews/:id" do
  set_review
  if @review && auth_user 
    @review.update(:title => params[:title], :content => params[:content])
    @review.save
    redirect "/reviews/#{@review.id}"
  else 
    redirect "/reviews"
  end
end

get "/reviews/:id/edit" do
  set_review 
  if @review && auth_user
    erb :"reviews/edit"  
  else 
    redirect "reviews/error"
  end    
end

  delete '/reviews/:id/delete' do
    set_review 
    if @review && auth_user
      @review.delete 
      redirect "/reviews"  
    else 
      erb :"reviews/error"
    end    
  end

  private 

  def set_review 
    @review = Review.find_by_id(params[:id])
  end
  
  def auth_user 
    @review.user.id == current_user.id
  end 

end 