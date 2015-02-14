class AddVoteToUserVoitings < ActiveRecord::Migration
  def change
    add_column :user_votings, :vote, :boolean
  end
end
