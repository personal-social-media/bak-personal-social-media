# frozen_string_literal: true

RSpec.shared_context "api_comments_update" do
  let(:documentation_title) { "Update comment" }
  let(:documentation_unescaped_url) { "/api/comments/:id" }
  let(:documentation_id) { :update }
  let(:documentation_params) do
    {
      comment: {
        signature: {
          type: :signature
        },
        payload: {
          message: {
            type: :string
          },
          subject_id: {
            type: :uid
          },
          subject_type: {
            type: :string,
            variants: CacheComment.payload_subject_types
          },
          parent_comment_id: {
            type: :uid,
            optional: true
          },
          images: [
            {
              original: {
                type: :url
              },
              mobile: {
                type: :url
              },
              thumbnail: {
                type: :url
              },
              size: {
                width: {
                  type: :string
                },
                height: {
                  type: :string
                }
              }
            }
          ],
          videos: [
            {
              original: {
                type: :url
              },
              original_screenshot: {
                type: :url
              },
              thumbnail_screenshot: {
                type: :url
              },
              short: {
                type: :url
              },
              size: {
                width: {
                  type: :string
                },
                height: {
                  type: :string
                }
              }
            }
          ]
        }
      },
    }
  end
end
