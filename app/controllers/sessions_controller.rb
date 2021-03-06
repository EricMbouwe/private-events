class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by name: params[:name]

    if @user
      ApplicationController.cash_session_user_id_for_testing(@user.id) if Rails.env.test?

      session[:user_id] = @user.id
      redirect_to events_path
    else
      flash.alert = "'" + params[:name] + "' : is a Wrong User Name !!"

      redirect_to new_session_path
    end
  end

  def destroy
    ApplicationController.cash_session_user_id_for_testing(nil) if Rails.env.test?

    session[:user_id] = nil
    redirect_to new_session_path
  end
end
