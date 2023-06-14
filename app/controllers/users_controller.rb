require 'csv'

class UsersController < ApplicationController
  
  def export
    @users = User.all
    send_data @users.to_csv, filename: "users-#{Date.today}.csv", type: 'text/csv', disposition: 'attachment'
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

  def forgot_password
    # Find the user by email or username
    @user = User.find_by(email: params["email"])

    if @user
      # Generate and store a password reset token
      @user.generate_password_reset_token
      @user.save

      # Send the password reset instructions email
      UserMailer.password_reset_email(@user).deliver_now

      flash["notice"] = "An email with instructions to reset your password has been sent."
      redirect_to "/login"
    else
      flash["notice"] = "Sorry, the provided username or email address was not found."
      redirect_to "/forgot_password"
    end
  end
  
    

end