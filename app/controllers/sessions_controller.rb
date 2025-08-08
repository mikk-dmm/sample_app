class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:emial].downcase)
    if user && user.authenticate(params[:session][:password])
      render ''
    else
      flash.now[:danger] = 'Invalid email/password combination'
    end
    render 'new', status: :unprocessable_entity
  end

  def destroy
    
  end
end
