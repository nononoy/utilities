class CreateVotingQuestions < ActiveRecord::Migration
  def change
    create_table :voting_questions do |t|
      t.references :voting, index: true
      t.text :description, limit: 500

      t.timestamps null: false
    end
    add_foreign_key :voting_questions, :votings
  end
end
