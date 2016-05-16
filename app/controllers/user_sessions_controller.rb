class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password], params[:remember_me])
    if @user
      # redirect_back_or_to(:votings_path, notice: 'Успешный вход!')
      redirect_to votings_path, notice: 'Успешный вход!'
    else
      flash.now[:alert] = 'Проблемы авторизации'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: 'Успешный выход!'
  end
end
