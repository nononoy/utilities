class CreateUserBuildings < ActiveRecord::Migration
  def change
    create_table :user_buildings do |t|
      t.references :user, index: true
      t.references :building, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_buildings, :users
    add_foreign_key :user_buildings, :buildings
  end
end
