# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id             :bigint           not null, primary key
#  comments_count :bigint           default(0), not null
#  content        :text
#  like_count     :bigint           default(0), not null
#  location_name  :text
#  love_count     :bigint           default(0), not null
#  mood           :string
#  privacy        :string           default("public_access"), not null
#  uid            :string           not null
#  wow_count      :bigint           default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Post < ApplicationRecord
  include PrivacyConcern
  include UidConcern
  has_many :attached_files, as: :subject, dependent: :destroy
  has_many :reactions, as: :subject, dependent: :destroy
  has_many :comments, as: :subject, dependent: :destroy
  after_create :add_feed_item
  after_commit :sync_destroy, on: :destroy

  def sync_create
    SyncWorker.perform_async(Post, id, SyncService::SyncPost, :call_create!)
  end

  def sync_destroy
    remove_feed_item
    SyncService::SyncPostDestroy.perform_async_service(:call_destroy!, uid)
  end

  def attachments_ready!
    sync_create
  end

  private
    def add_feed_item
      PostService::CreateSelfFeedItem.new(self).call!
    end

    def remove_feed_item
      PostService::RemoveSelfFeedItem.new(self).call!
    end
end
