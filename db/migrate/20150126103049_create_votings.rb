class CreateVotings < ActiveRecord::Migration
  def change
    create_table :votings do |t|
      t.references :user, index: true
      t.date :start_at
      t.datetime :end_at
      t.text :description
      t.string :title
      t.string :attachment
      t.boolean :notify_all, default: false
      t.boolean :is_closed, default: false
      t.boolean :is_published, default: false

      t.timestamps null: false
    end
    add_foreign_key :votings, :users
  end
end
