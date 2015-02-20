class AddPercentToUserVotingQuestions < ActiveRecord::Migration
  def change
    add_column :user_voting_questions, :percent, :decimal, precision: 5, scale: 4
  end
end
