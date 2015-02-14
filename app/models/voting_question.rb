# t.integer  "voting_id",   limit: 4
# t.text     "description", limit: 65535
# t.datetime "created_at",                null: false
# t.datetime "updated_at",                null: false

class VotingQuestion < ActiveRecord::Base

  belongs_to :voting
  has_one :building, through: :voting
  has_many :attachments, as: :attachable
  has_many :user_voting_questions, dependent: :destroy

  def files=(files)
    files.each do |file|
      attachments.build(file: file) if file
    end
  end


  def get_accept_percent
    num_of_facilities = building.num_of_facilities || building.user_buildings.count
    accepted_facilities = user_voting_questions.accepted.count
    accepted_facilities.to_f / num_of_facilities * 100
  end

  def get_discard_percent
    num_of_facilities = building.num_of_facilities || building.user_buildings.count
    discarded_facilities = user_voting_questions.discarded.count
    discarded_facilities.to_f / num_of_facilities * 100
  end

end
