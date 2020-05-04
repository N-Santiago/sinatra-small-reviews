class SessionsController < ApplicationController 

	get "/signup" do
		if logged_in?
			redirect to '/reviews'
		erb :"users/signup"
		end         
    end 

    post "/signup" do
		@user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
        if @user.save
			session[:user_id] = @user.id
			redirect "/reviews"
		  else
			redirect "/signup"
		  end
    end
    
	get "/login" do
		if logged_in?
			redirect to '/reviews'
		erb :"users/login"
		end 
	end

    post "/login" do
	    @user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect "/reviews"
		else
			redirect "/login"
		end
  end

get "/logout" do
	session.clear
	redirect "/"
end

	helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end

end