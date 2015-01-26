class UserVoting < ActiveRecord::Base
  belongs_to :user
  belongs_to :voting
end
