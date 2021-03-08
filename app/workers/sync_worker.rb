# frozen_string_literal: true

class SyncWorker < ApplicationWorker
  def perform(model, id, service, method)
    return unless Rails.env.production?
    record = model.constantize.find_by(id: id)
    return if record.blank?

    service.constantize.new(record).tap do |s|
      s.send(method)
    end
  end
end
