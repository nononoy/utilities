class UserVotingQuestionsController < ApplicationController


  def accept
    user_voting_question = current_user.user_voting_questions.where(voting_question_id: params[:voting_question_id]).first_or_create
    user_voting_question.update(vote: :accept)
    render partial: 'votings/already_vote'
  end

  def discard
    user_voting_question = current_user.user_voting_questions.create(voting_question_id: params[:voting_question_id]).first_or_create
    user_voting_question.update(vote: :discard)
    render partial: 'votings/already_vote'
  end

end
