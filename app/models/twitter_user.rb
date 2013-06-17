class TwitterUser < ActiveRecord::Base
  has_many :tweets
  # Remember to create a migration!
end
