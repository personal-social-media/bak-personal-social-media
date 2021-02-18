# frozen_string_literal: true

class SyncServiceWorker < ApplicationWorker
  def perform(klass, method_called, *arguments)
    klass.constantize.new(*arguments).send(method_called)
  end
end
