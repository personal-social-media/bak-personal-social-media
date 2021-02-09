# frozen_string_literal: true

namespace :test do
  desc "Recreates the test account"
  task recreate_account: :environment do
    raise "Only in TEST env, please run with RAILS_ENV=test" if Rails.env.production?
    Rails.env = "test"
    ENV["RAILS_ENV"] = "test"

    ip = "161.97.64.223"
    peer = FactoryBot.build(:peer_info, ip: ip, friend_ship_status: :stranger)
    begin
      FriendshipClientService::Destroy.new(peer, "destroy").call!
    rescue FriendshipClientService::Destroy::Error => e
      p e
    end
    FriendshipClientService::Create.new(peer).call!
  end
end
