class UsersController < ApplicationController 
    
    get "/users/:id" do
        @user = User.find(params[:id])
        erb :"/users/show"
    end 
    
    delete "/users/:id" do
        @user = User.find(params[:id])

    end 

end 