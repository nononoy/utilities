class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create, :activate]
  before_action :set_user, only: [:show, :update, :destroy]

  def activate
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      redirect_to(votings_path(tab: "cabinet"), :notice => 'Вы успешно активировали свою учетную запись')
    else
      not_authenticated
    end
  end

  def index
    @users = User.all
  end

  def show
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: 'Проверьте свою почту и завершите регистрацию нажав на большую ссылку.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to votings_path(tab: "cabinet"), notice: 'Успешное редактирование' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit( :first_name, :surname, :middle_name, :agreement,
        :email, :phone, :password, :password_confirmation, :status, :document_type, :notify_me,
        :series, :number, :date_of_issue, :country_of_issue, :issuing_authority, :type_of_organization, :org_full_name, :org_ogrn,:org_inn,
        user_buildings_attributes: [:id, :city, :street, :building_number, :apartment, :series,
          :number, :date_of_issue, :certificate, :share, :facility_square, :address, :_destroy,
          :num_of_facilities, :full_building_square,
          building_attributes: [ :id, :num_of_facilities, :full_building_square ]
        ]
      )
    end
end
