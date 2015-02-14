module UsersHelper
  def get_appartments(user_buildings, building_id)
    @user_buildings.select{ |ub| ub.building_id == building_id }.map(&:apartment).join(", ")
  end
end
