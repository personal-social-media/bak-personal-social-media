# frozen_string_literal: true

class SyncWorker < ApplicationWorker
  def perform(model, id, service, method)
    record = model.constantize.find_by(id: id)
    return if record.blank?

    service.constantize.new(record).send(method)
  end
end
