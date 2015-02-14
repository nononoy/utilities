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
      puts "== refrained_voting_questions.count =="
      puts refrained_voting_questions.count
      refrained_voting_questions.each do |voting_question|
        voting_question.user_voting_questions.create(user_id: user_id, vote: :refrain)
      end
    end
end
