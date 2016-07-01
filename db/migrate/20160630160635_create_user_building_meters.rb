class CreateUserBuildingMeters < ActiveRecord::Migration
  def change
    create_table :user_building_meters do |t|
      t.references :user_building, index: true
      t.boolean :enabled, null: false, default: false
      t.string :name
      t.string :number
      t.timestamps null: false
    end
    add_foreign_key :user_building_meters, :user_buildings
  end
end
