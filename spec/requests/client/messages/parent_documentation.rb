# frozen_string_literal: true

RSpec.shared_context "client_messages_documentation" do
  let(:documentation_parent_title) { "Messages" }
  let(:documentation_usage) { :internal }
  let(:documentation_parent_id) { :client_messages }
  let(:controller) { Client::MessagesController }
end
