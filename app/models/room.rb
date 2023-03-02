class Room < ApplicationRecord
  # Associations
  has_many :messages

  # Validations
  validates_uniqueness_of :name

  # create a scope to fetch all users except the current user for our user list, 
  # as we do not want a user chatting with himself
  scope :public_rooms, -> { where(is_private: false) }

  # Turbo Broadcast
  # broadcast any newly added instance to a particular channel
  after_create_commit { broadcast_append_to "rooms" }
end
