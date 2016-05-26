class User < ActiveRecord::Base
  extend Enumerize

  authenticates_with_sorcery!

  attr_accessor :agreement

  # validates :password, length: { minimum: 4 }, confirmation: true, on: :create
  # validates :password_confirmation, presence: true, if: '!password.nil?' #on: :create

  validates :password,                presence: true, confirmation: true, length: { minimum: 4}, if: :password
  validates :password_confirmation,   presence: true, if: '!password.nil?'

  validates :email, uniqueness: true, presence: true
  validates :agreement, format: { with: /1/i, on: :create, message: 'Вы должны согласиться для продолжения работы' }

  has_many :votings, dependent: :destroy
  has_many :user_voting_questions, dependent: :destroy

  has_many :user_buildings, dependent: :destroy, counter_cache: true
  has_many :buildings, -> {
    select(%Q(buildings.*,
      user_buildings.apartment AS apartment,
      user_buildings.share AS share,
      user_buildings.address AS address,
      user_buildings.facility_square AS facility_square))
    }, through: :user_buildings
  has_many :building_votings, through: :user_buildings, source: :votings


  accepts_nested_attributes_for :user_buildings, reject_if: :all_blank, allow_destroy: true


  enumerize :status, in: { individual: 1, legal: 2, management_company: 3 }, default: :individual
  enumerize :type_of_organization, in: { ao: 1, ooo: 2, odo: 3 }
  enumerize :document_type, in: { russian_passport: 1, birth_certificate: 2 }


  def is_management_company?
    status == 'management_company'
  end

  def has_building?
    # user_buildings.any?
    buildings.where.not(full_building_square: nil).any?
  end

  def can_vote?(voting_question)
    return false if status == "management_company"
    return true unless user_voting_questions.where(voting_question: voting_question).any?
    user_voting_questions.where(voting_question: voting_question).refrained.any?
  end

  def apartments
    buildings.inject({}){ |hash, b| hash[b.id] ||= []; hash[b.id] << b.apartment; hash }
  end

  def full_name
    "#{surname} #{first_name} #{middle_name}"
  end

  def user_buildings_by_building(building)
    building_id = building.kind_of?(Building) ? building.id : building
    user_buildings.where(building_id: building_id)
  end

  def is_admin?
    true
  end

end
