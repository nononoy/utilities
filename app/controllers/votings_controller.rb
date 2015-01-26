class VotingsController < ApplicationController

  def index
  end

  def new
    @voting = Voting.new user_id: current_user.id
  end


  private

    def user_params
      params.require(:voting).permit(:user_id)
    end
end
