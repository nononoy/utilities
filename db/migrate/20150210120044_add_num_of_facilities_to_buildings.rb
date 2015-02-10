class AddNumOfFacilitiesToBuildings < ActiveRecord::Migration
  def change
    add_column :buildings, :num_of_facilities, :integer
    add_column :buildings, :full_building_square, :integer
  end
end
