class ChangeVoteInUserVotingQuestions < ActiveRecord::Migration
  def change
    change_column :user_voting_questions, :vote, :integer
  end
end
