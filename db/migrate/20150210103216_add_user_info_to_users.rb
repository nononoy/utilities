class AddUserInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :series, :string
    add_column :users, :number, :string
    add_column :users, :date_of_issue, :date
    add_column :users, :country_of_issue, :string
    add_column :users, :issuing_authority, :text, limit: 500
    add_column :users, :type_of_organization, :integer
    add_column :users, :org_full_name, :string
    add_column :users, :org_ogrn, :string
    add_column :users, :org_inn, :string
  end
end
