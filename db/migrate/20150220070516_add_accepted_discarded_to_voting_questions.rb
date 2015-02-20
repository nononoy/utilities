class AddAcceptedDiscardedToVotingQuestions < ActiveRecord::Migration
  def change
    add_column :voting_questions, :accepted_percent, :decimal, precision: 5, scale: 4
    add_column :voting_questions, :discarded_percent, :decimal, precision: 5, scale: 4
    add_column :voting_questions, :refrained_percent, :decimal, precision: 5, scale: 4
  end
end
