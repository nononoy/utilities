class UserBuildingMetersController < ApplicationController

  def index
  end

  def new
    building = UserBuilding.find_by_id(params[:building])
    @user_building_meter = building.user_building_meters.new
  end

  def create
    puts params[:user_building_meter]
    @user_building_meter = UserBuildingMeter.new voting_params
    if @user_building_meter.save
      redirect_to votings_path(tab: "apartment"), notice: 'Счётчик успешно создан'
    else
      render :new
    end
  end

  def update_all
    params['user_building_meter'].keys.each do |id|
      @meter = UserBuildingMeter.find_by_id(id.to_s)
      @meter.update(enabled: params['user_building_meter'][id]['enabled'] == "1",
                    name:  params['user_building_meter'][id]['name'],
                    number:  params['user_building_meter'][id]['number'])
    end
    redirect_to votings_path(tab: "apartment"), notice: 'Успешное редактирование'
  end

  def send_data
    redirect_to votings_path(tab: "apartment"), notice: "Данные успешно отправлены"
  end

  private

  def voting_params
    params.require(:user_building_meter).permit(:name, :number, :user_building_id)
  end
end
