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

get '/reviews/:id/edit' do
    if !logged_in?
      redirect to '/login'
    end 
    @review = Review.find(params[:id])
    if @review && @review.user == current_user
      erb :'reviews/edit'
    else
      redirect to '/reviews'
    end
  end

patch '/reviews/:id' do
    if !logged_in?
      redirect to '/login'
    end 
    if params[:content] == ""
      redirect to "/reviews/#{params[:id]}/edit"
    else
      @review = Review.find_by_id(params[:id])
      if @review && @review.user == current_user
        if @review.update(content: params[:content])
          redirect to "/reviews/#{@review.id}"
        else
          redirect to "/reviews/#{@review.id}/edit"
        end
      else
        redirect to '/reviews'
      end
    end
  end  

#delete_review

end 