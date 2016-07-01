# num_of_facilities
# full_building_square

class Building < ActiveRecord::Base

  has_many :user_buildings, dependent: :destroy
  has_many :users, through: :user_buildings

  has_many :votings, dependent: :destroy

  scope :with_square, -> { where.not(full_building_square: nil) }


  def short_address
    "#{city}, #{street}, #{number}"
  end

  def appartment_summary(user)
    "кв. №#{apartment} Собственник #{self.users.ids.index(user.id) + 1} из #{self.users.count} (#{user.email})"
  end

end
