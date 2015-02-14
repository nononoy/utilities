class CreateUserVotingQuestions < ActiveRecord::Migration
  def change
    create_table :user_voting_questions do |t|
      t.references :user, index: true
      t.references :voting_question, index: true
      t.boolean :vote
      t.timestamps null: false
    end
    add_foreign_key :user_voting_questions, :users
    add_foreign_key :user_voting_questions, :voting_questions
  end
end
