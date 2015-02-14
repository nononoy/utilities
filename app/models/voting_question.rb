# t.integer  "voting_id",   limit: 4
# t.text     "description", limit: 65535
# t.datetime "created_at",                null: false
# t.datetime "updated_at",                null: false

class VotingQuestion < ActiveRecord::Base

  belongs_to :voting
  has_many :attachments, as: :attachable

  def files=(files)
    files.each do |file|
      attachments.build(file: file) if file
    end
  end


end
