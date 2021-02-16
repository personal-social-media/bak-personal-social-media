# frozen_string_literal: true

module ShrineWorker
  class Promote < ApplicationWorker
    attr_reader :record
    include Sidekiq::Throttled::Worker
    sidekiq_options retry: 1, queue: :files
    sidekiq_throttle(concurrency: { limit: 2 })

    def perform(attacher_class, record_class, record_id, name, file_data)
      attacher_class = Object.const_get(attacher_class)
      @record = Object.const_get(record_class).find(record_id)

      attacher = attacher_class.retrieve(model: record, name: name, file: file_data)
      attacher.atomic_promote
      update_relationship_status(:processed)
    rescue Shrine::AttachmentChanged, ActiveRecord::RecordNotFound
      update_relationship_status(:failed)
    rescue ActiveRecord::RecordNotFound
      true
    rescue Exception => e
      update_relationship_status(:failed)
      raise e
    end

    def update_relationship_status(value)
      record.gallery_elements.update_all(processing_status: value)
      record.attached_files.update_all(processing_status: value)
    end
  end
end
