# t.integer  "user_id",       limit: 4
# t.integer  "building_id",   limit: 4
# t.datetime "created_at",                                  null: false
# t.datetime "updated_at",                                  null: false
# t.integer  "apartment",     limit: 4
# t.integer  "share",         limit: 4
# t.text     "address",       limit: 65535
# t.string   "series",        limit: 255
# t.string   "number",        limit: 255
# t.date     "date_of_issue"
# t.string   "certificate",   limit: 255
# t.boolean  "is_submitted",  limit: 1,     default: false

class UserBuilding < ActiveRecord::Base

  mount_uploader :certificate, CertificateUploader

  attr_accessor :city, :street, :building_number, :num_of_facilities, :full_building_square

  belongs_to :user
  belongs_to :building
  has_many :votings, through: :building

  accepts_nested_attributes_for :building, reject_if: :all_blank

  before_create :set_building

  scope :by_building, -> (building) { where(building: building) }

  private

    def set_building
      unless building_id.present?
        self.building = Building.where(city: city, street: street, number: building_number).first_or_create
        if num_of_facilities.present? && full_building_square.present?
          building.update num_of_facilities: num_of_facilities, full_building_square: full_building_square
        end
      end
    end

end
