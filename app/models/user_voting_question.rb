class UserVotingQuestion < ActiveRecord::Base
  extend Enumerize

  belongs_to :user
  belongs_to :voting_question
  has_one :voting, through: :voting_question

  scope :accepted, -> { where(vote: 1) }
  scope :discarded, -> { where(vote: 2) }
  scope :refrained, -> { where(vote: 3) }

  enumerize :vote, in: { accept: 1, discard: 2, refrain: 3 }


  after_update :set_refrain_questions
  after_create :calculate_percent


  def refrained_voting_questions
    voting_question_ids = voting.user_voting_questions
      .where(user_voting_questions: { user_id: user_id })
      .pluck :voting_question_id
    voting.voting_questions.where.not(id: voting_question_ids)
  end


  private
    # если собственник проголосовал по одному вопросу из собрания, но не проглосовал по другому,
    # то считается что он воздержался
    def set_refrain_questions
      return unless ["accept", "discard"].include?(vote)
      return unless vote_changed?
      refrained_voting_questions.each do |voting_question|
        voting_question.user_voting_questions.create(user_id: user_id, vote: :refrain)
      end
    end

    # Человек владеющий долей в 35 метровой квартире в размере 20% в доме где общая площадь 20000 метров,
    # его голос по вопросу равен 0,2 * (35/20000) (то есть 0,2*0,00175*100%=0,035%).
    def calculate_percent
      building = voting.building
      # площадь здания
      full_building_square = building.full_building_square
      result = 0.0
      user.user_buildings.where(building_id: building.id).each do |user_building|
        # площадь квартиры
        user_building_square = user_building.facility_square
        # доля квартиры
        user_building_share  = user_building.share
        result += (user_building_share / 100.0) * (user_building_square/full_building_square.to_f)
      end
      result *= 100
      update(percent: result)
    end
end
