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

#edit_review

#delete_review

end 