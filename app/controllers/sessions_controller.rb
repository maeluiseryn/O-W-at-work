class SessionsController < ApplicationController
  def new
    @title='User Sign-In'
  end
  def create
     user = User.authenticate(params[:session][:email],params[:session][:password])
    if user.nil?
        flash.now[:error] = "Invalid email/password combination."
        @title = "Sign in"
        render 'new'
        else
        sign_in user
        if signed_in?  # test not vital
        redirect_to user
        else
        redirect_to users_path
        end
    end
  end
  def destroy
    sign_out
    redirect_to root_path
  end
end
