# frozen_string_literal: true

# == Schema Information
#
# Table name: peer_infos
#
#  id                 :bigint           not null, primary key
#  avatar_url         :text
#  friend             :boolean          default(FALSE), not null
#  friend_ship_status :string
#  ip                 :string           not null
#  public_key         :text             not null
#  username           :text             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_peer_infos_on_username_and_ip  (username,ip)
#
class PeerInfo < ApplicationRecord
  str_enum :friend_ship_status, %i(requested pending declined self)
end
