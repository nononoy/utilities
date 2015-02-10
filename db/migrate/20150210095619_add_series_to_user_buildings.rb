class AddSeriesToUserBuildings < ActiveRecord::Migration
  def change
    add_column :user_buildings, :series, :string
    add_column :user_buildings, :number, :string
    add_column :user_buildings, :date_of_issue, :date
    add_column :user_buildings, :certificate, :string
    add_column :user_buildings, :is_submitted, :boolean, default: false
  end
end
