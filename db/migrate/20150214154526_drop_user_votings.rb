class DropUserVotings < ActiveRecord::Migration
  def change
    drop_table :user_votings
  end
end
