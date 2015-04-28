# app/controllers/password_resets_controller.rb
class PasswordResetsController < ApplicationController
  skip_before_filter :require_login

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_reset_password_instructions!
      redirect_to(login_path, notice: 'Мы отправили вам email с инструкциями восстановления')
    else
      flash.now[:alert] = 'Email не найден'
      render :create
    end
  end

  # This is the reset password form.
  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password!(params[:user][:password])
      redirect_to(login_path, :notice => 'Вы успешно изменили пароль. Теперь Вы можете входить с систему.')
    else
      render :action => "edit"
    end
  end
end
