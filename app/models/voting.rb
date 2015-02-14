# t.integer  "user_id"
# t.date     "start_at"
# t.datetime "end_at"
# t.text     "description"
# t.string   "title"
# t.string   "attachment"
# t.boolean  "notify_all",   default: false
# t.boolean  "is_closed",    default: false
# t.boolean  "is_published", default: false
# t.datetime "created_at"
# t.datetime "updated_at"


class Voting < ActiveRecord::Base

  mount_uploader :attachment, FileUploader

  belongs_to :user
  belongs_to :building
  validates_presence_of :user_id, :title, :start_at, :end_at, :description

  has_many :voting_questions, dependent: :destroy
  has_many :user_voting_questions, through: :voting_questions

  accepts_nested_attributes_for :voting_questions, reject_if: :all_blank, allow_destroy: true

  # scope :closed, -> { where(is_closed: true) }
  scope :closed, -> { where("votings.end_at < ?", Time.now.utc) }
  scope :published, -> { where(votings: { is_published: true }) }
  scope :drafts, -> { where(votings: { is_published: false }) }

  scope :active, -> { where("votings.end_at >= ?", Time.now.utc) }


  before_create :set_end_at

  private
    def set_end_at
      # self.start_at = start_at.utc
      self.end_at = end_at.to_datetime.change(offset: "+0300")
    end


end
