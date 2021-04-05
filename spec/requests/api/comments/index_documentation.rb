# frozen_string_literal: true

RSpec.shared_context "api_comments_index" do
  let(:documentation_title) { "List comments" }
  let(:documentation_information) { "List messages for a resource" }
  let(:documentation_unescaped_url) { "/api/comments/:id" }
  let(:documentation_id) { :index }
  let(:documentation_params) do
    {
      subject_type: {
        type: :string,
        variants: %w(post)
      },
      subject_id: {
        type: :uid
      },
      parent_comment_id: {
        type: :id
      },
      page: { type: :number, optional: true }, start_index: { type: :number, optional: true }, end_index: { type: :number, optional: true }
    }
  end
end
