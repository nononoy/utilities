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

  has_many :user_votings, dependent: :destroy

  # scope :closed, -> { where(is_closed: true) }
  scope :closed, -> { published.where("end_at < ?", Time.now.utc) }
  scope :published, -> { where(is_published: true) }
  scope :drafts, -> { where(is_published: false) }

  scope :active, -> { published.where("end_at >= ?", Time.now.utc) }


  before_create :set_end_at

  # def set_building
  #   self.building = user.house
  # end

  private
    def set_end_at
      # self.start_at = start_at.utc
      self.end_at = end_at.to_datetime.change(offset: "+0300")
    end


end
