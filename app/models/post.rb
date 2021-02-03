# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id            :bigint           not null, primary key
#  content       :text
#  like_count    :integer          default(0), not null
#  location_name :text
#  love_count    :integer          default(0), not null
#  mood          :string
#  uid           :string           not null
#  wow_count     :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Post < ApplicationRecord
  include UidConcern
  has_many :attached_files, as: :subject, dependent: :destroy
  after_commit :sync_create, on: :create if Rails.env.production?
  after_create :add_feed_item

  private
    def sync_create
      SyncWorker.perform_async(Post, id, SyncService::SyncPost, :call_create!)
    end

    def add_feed_item
      PostService::CreateSelfFeedItem.new(self).call!
    end
end
