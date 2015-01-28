class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 4 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true

  has_many :votings, dependent: :destroy
  has_many :user_votings, dependent: :destroy


  has_many :user_buildings, dependent: :destroy
  has_many :buildings, -> {
    select("buildings.*, user_buildings.apartment AS apartment, user_buildings.share AS share, user_buildings.address AS address")
    }, through: :user_buildings
  has_many :building_votings, through: :buildings, source: :votings


  accepts_nested_attributes_for :user_buildings, reject_if: :all_blank, allow_destroy: true

end
