class ChangeVotinQuestionPercent < ActiveRecord::Migration
  def change
    change_column :voting_questions, :accepted_percent, :decimal, precision: 7, scale: 4
    change_column :voting_questions, :discarded_percent, :decimal, precision: 7, scale: 4
    change_column :voting_questions, :refrained_percent, :decimal, precision: 7, scale: 4
  end
end
