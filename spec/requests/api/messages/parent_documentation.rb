# frozen_string_literal: true

RSpec.shared_context "api_messages" do
  let(:documentation_parent_title) { "Messages" }
  let(:documentation_usage) { :external }
  let(:documentation_parent_id) { :api_messages }
  let(:controller) { Api::MessagesController }
end
