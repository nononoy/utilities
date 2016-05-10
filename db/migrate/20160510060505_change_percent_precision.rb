class ChangePercentPrecision < ActiveRecord::Migration
  def change
    change_column :user_voting_questions, :percent, :decimal, precision: 7, scale: 4
  end
end
