class GroupMembership < ApplicationRecord
  belongs_to :group
  belongs_to :peer_info
end
