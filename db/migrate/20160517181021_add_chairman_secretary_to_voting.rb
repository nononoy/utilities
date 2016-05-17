class AddChairmanSecretaryToVoting < ActiveRecord::Migration
  def change
    add_column :votings, :chairman, :string
    add_column :votings, :secretary, :string
  end
end
