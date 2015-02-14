class AddFacilitySquareToUserBuildings < ActiveRecord::Migration
  def change
    add_column :user_buildings, :facility_square, :integer, after: :share
  end
end
