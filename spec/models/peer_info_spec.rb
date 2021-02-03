# frozen_string_literal: true

# == Schema Information
#
# Table name: peer_infos
#
#  id                 :bigint           not null, primary key
#  avatars            :text
#  friend             :boolean          default(FALSE), not null
#  friend_ship_status :string
#  ip                 :string           not null
#  name               :text
#  public_key         :text             not null
#  username           :text             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_peer_infos_on_name             (name) USING gin
#  index_peer_infos_on_username_and_ip  (username,ip)
#
require "rails_helper"

RSpec.describe PeerInfo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
