# frozen_string_literal: true

RSpec.shared_context "api_comments_update" do
  let(:documentation_title) { "Updates a comment" }
  let(:documentation_unescaped_url) { "/api/comments/:id" }
  let(:documentation_id) { :update }
  let(:documentation_params) do
    {
      comment: {
        signature: {
          type: :string
        },
        payload: {
          message: {
            type: :string
          },
          subject_id: {
            type: :string
          },
          subject_type: {
            type: :string
          },
          parent_comment_id: {
            type: :number,
            optional: true
          },
          images: [
            {
              type: {
                type: :string
              },
              desktop: {
                type: :url
              },
              mobile: {
                type: :url
              },
              thumbnail: {
                type: :url
              },
            }
          ],
          videos: [
            {
              type: {
                type: :string
              },
              original: {
                type: :url
              },
              short: {
                type: :url
              },
              original_screenshot: {
                type: :url
              },
              thumbnail_screenshot: {
                type: :url
              },
            }
          ]
        }
      },
    }
  end
end
