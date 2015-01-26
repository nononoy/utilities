class CreateUserVotings < ActiveRecord::Migration
  def change
    create_table :user_votings do |t|
      t.references :user, index: true
      t.references :voting, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_votings, :users
    add_foreign_key :user_votings, :votings
  end
end
