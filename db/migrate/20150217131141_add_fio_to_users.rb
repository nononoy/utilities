class AddFioToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, after: :id
    add_column :users, :surname, :string, after: :first_name
    add_column :users, :middle_name, :string, after: :surname
  end
end
