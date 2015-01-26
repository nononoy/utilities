class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password], params[:remember_me])
      redirect_back_or_to(:votings, notice: 'Успешный вход!')
    else
      flash.now[:alert] = 'Проблемы авторизации'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:votings, notice: 'Успешный выход!')
  end
end
