# frozen_string_literal: true

RSpec.shared_context "api_comments_create" do
  let(:documentation_title) { "Create new message" }
  let(:documentation_unescaped_url) { "/api/comments" }
  let(:documentation_id) { :create }
  let(:documentation_params) do
    {
      comment: {
        subject_type: {
          type: :string
        },
        subject_id: {
          type: [:string, :integer],
        },
        comment_type: {
          type: :string
        },
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
