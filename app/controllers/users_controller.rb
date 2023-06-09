class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user["firstname"] = params["user"]["firstname"]
    @user["lastname"] = params["user"]["lastname"]
    @user["username"] = params["user"]["username"]
    @user["password"] = BCrypt::Password.create(params["user"]["password"])
    @user.save
    redirect_to "/"
  end
end