class AddUserBuildingCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_buildings_count, :integer, default: 0
    User.all.each do |u|
      User.where(id: u.id).update_all(user_buildings_count: u.user_buildings.count)
    end
  end
end
