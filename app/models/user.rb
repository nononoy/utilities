class User < ActiveRecord::Base
  extend Enumerize

  authenticates_with_sorcery!


  validates :password, length: { minimum: 4 }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :email, uniqueness: true

  has_many :votings, dependent: :destroy
  has_many :user_voting_questions, dependent: :destroy


  has_many :user_buildings, dependent: :destroy
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
  enumerize :document_type, in: { russian_passport: 1, foreign_passport: 2,
    residence_permit_of_foreign_citizen: 3, residence_permit_stateless_persons: 4, birth_certificate: 5 }


  def is_management_company?
    status == 'management_company'
  end

  def has_building?
    user_buildings.any?
  end

  def can_vote?(voting_question)
    return true unless user_voting_questions.where(voting_question: voting_question).any?
    user_voting_questions.where(voting_question: voting_question).refrained.any?
  end

  def apartments
    buildings.inject({}){ |hash, b| hash[b.id] ||= []; hash[b.id] << b.apartment; hash }
  end

end
