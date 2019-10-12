class TravelerController < ApplicationController

    get "/signup" do
        erb :"travelers/signup"
      end
    
    post '/signup' do
      traveler = Traveler.new(params)
      traveler.save
      if traveler.save
        session[:traveler_id] = traveler.id
        redirect "/goals"
      else
        flash[:error] = "Something went wrong. Please try again!"
        redirect "/signup"
      end
    end
    
    
      get '/login' do
        erb :'travelers/login'  
      end
    
      post '/login' do
         # figure out if the user exists db
        @traveler = Traveler.find_by(email:params[:email])
        # if they do exist verify password
        if @traveler && @traveler.authenticate(params[:password])
            # set our sesssion hash and redirect to goals home 
          session[:traveler_id] = @traveler.id
          redirect '/goals'
        else
          flash[:error] = "Incorrect email or password. Please try again!"
          redirect '/login'
        end
      end
    
      get "/logout" do
        if logged_in? 
          session.destroy
          redirect '/login' 
        else
          flash[:error] = "Something went wrong. Please try again!"
          redirect "/"
        end
      end
      
end 