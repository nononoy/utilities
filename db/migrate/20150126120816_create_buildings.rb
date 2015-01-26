class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :city
      t.string :street
      t.string :number

      t.timestamps null: false
    end
  end
end
