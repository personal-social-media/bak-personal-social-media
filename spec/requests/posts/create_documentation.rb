# frozen_string_literal: true

RSpec.shared_context "posts_create_documentation" do
  let(:documentation_title) { "Create post" }
  let(:documentation_unescaped_url) { "/posts/upload" }
  let(:documentation_id) { :create }
  let(:documentation_params) do
    {
      post: {
        content: {
          type: :string
        },
        uploaded_files: {
          type: :files,
          list: true
        }
      }
    }
  end
end
