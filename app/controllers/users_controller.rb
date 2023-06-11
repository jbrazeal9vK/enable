require 'csv'

class UsersController < ApplicationController
  
  def export
    @users = User.all
    send_data @users.to_csv, filename: "users-#{Date.today}.csv"
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user["username"] = params["user"]["username"]
    @user["location"] = params["user"]["location"]
    @user["email"] = params["user"]["email"]
    @user["password"] = BCrypt::Password.create(params["user"]["password"])
    if @user.save
      session[:user_id] = @user.id # This line starts a session for the new user
      redirect_to "/"
    else
      render :new
    end
  end

  def show
  end
  
    

end