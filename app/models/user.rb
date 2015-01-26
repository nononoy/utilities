class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 4 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true
  validates_presence_of :city, :street, :building, :apartment

  has_many :votings, dependent: :destroy

  has_many :user_buildings, dependent: :destroy
  has_many :buildings, through: :user_buildings

  has_many :user_votings, dependent: :destroy

  after_create :set_user_buildings


  def house
    Building.where(city: city, street: street, number: building).first_or_create
  end

  private

    def set_user_buildings
      user_buildings.where(building_id: house.id).first_or_create
    end

end
