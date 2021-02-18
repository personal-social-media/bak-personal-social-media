# frozen_string_literal: true

module AsyncService
  module RunAsync
    extend ActiveSupport::Concern

    class_methods do
      def perform_async_service(method_name, *arguments)
        SyncServiceWorker.perform_async(self.name, method_name, *arguments)
      end
    end
  end
end
