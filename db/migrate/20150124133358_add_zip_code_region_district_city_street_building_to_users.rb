class AddZipCodeRegionDistrictCityStreetBuildingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :zip_code, :string
    add_column :users, :region, :string
    add_column :users, :district, :string
    add_column :users, :city, :string
    add_column :users, :street, :string
    add_column :users, :building, :string
    add_column :users, :apartment, :integer
    add_column :users, :address, :text
  end
end
