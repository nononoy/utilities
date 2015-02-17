class AddNotifyMeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notify_me, :boolean, default: true
  end
end
