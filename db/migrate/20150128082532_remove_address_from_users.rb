class RemoveAddressFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :zip_code, :string
    remove_column :users, :region, :string
    remove_column :users, :district, :string
    remove_column :users, :city, :string
    remove_column :users, :street, :string
    remove_column :users, :building, :string
    remove_column :users, :apartment, :integer
    remove_column :users, :address, :text

    add_column :user_buildings, :apartment, :integer
    add_column :user_buildings, :share, :integer
    add_column :user_buildings, :address, :text, limit: 500
  end
end
