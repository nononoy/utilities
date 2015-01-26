class AddBuildingIdToVotings < ActiveRecord::Migration
  def change
    add_reference :votings, :building, index: true
    add_foreign_key :votings, :buildings
  end
end
