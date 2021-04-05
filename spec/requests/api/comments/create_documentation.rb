# frozen_string_literal: true

RSpec.shared_context "api_comments_create" do
  let(:documentation_title) { "Create message" }
  let(:documentation_unescaped_url) { "/api/comments" }
  let(:documentation_id) { :create }
  let(:documentation_params) do
    {
      comment: {
        subject_type: {
          type: :string,
          variants: CacheComment.payload_subject_types
        },
        subject_id: {
          type: :uid,
        },
        signature: {
          type: :signature
        },
        parent_comment_id: {
          type: :uid,
          optional: true
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
