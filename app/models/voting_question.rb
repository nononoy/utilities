# t.integer  "voting_id",   limit: 4
# t.text     "description", limit: 65535
# t.datetime "created_at",                null: false
# t.datetime "updated_at",                null: false
# accepted_percent
# discarded_percent
# refrained_percent
class VotingQuestion < ActiveRecord::Base

  belongs_to :voting
  has_one :building, through: :voting
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :user_voting_questions, dependent: :destroy

  scope :uncalculated, -> { where(voting_questions: { accepted_percent: nil }) }

  def files=(files)
    files.each do |file|
      attachments.build(file: file) if file
    end
  end

  def update_voting_percent!
    update(
      accepted_percent: user_voting_questions.accepted.sum(:percent),
      discarded_percent: user_voting_questions.discarded.sum(:percent),
      refrained_percent: user_voting_questions.refrained.sum(:percent)
    )
  end

end
