class VotingsController < ApplicationController

  def index
    @buildings = current_user.buildings.uniq
    @user_buildings = current_user.user_buildings.to_a
    building_votings = current_user.building_votings.includes(voting_questions: :attachments)
    @active_votings = building_votings.active.uniq
    @closed_votings = building_votings.closed.uniq
  end

  def new
    @voting = Voting.new user_id: current_user.id
  end

  def create
    @voting = Voting.new voting_params
    if @voting.save
      redirect_to voting_path(@voting), notice: 'Голосование успешно создано'
    else
      render :new
    end
  end

  def show
    @voting = Voting.find params[:id]
    @building = @voting.building
    @voting_questions = @voting.voting_questions.uniq
    @participated_square = @voting.user_buildings.pluck(:facility_square).inject(:+)
    @user_buildings = @building.user_buildings.includes(:user)
  end

  private

    def voting_params
      params.require(:voting).permit(
        :user_id, :description, :title, :start_at, :end_at, :notify_all, :is_published, :building_id,
        voting_questions_attributes: [ :description, :_destroy, files: []]
        )
    end
end
