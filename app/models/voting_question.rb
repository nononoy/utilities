# t.integer  "voting_id",   limit: 4
# t.text     "description", limit: 65535
# t.datetime "created_at",                null: false
# t.datetime "updated_at",                null: false

class VotingQuestion < ActiveRecord::Base

  mount_uploader :attachment, FileUploader
  belongs_to :voting

end
