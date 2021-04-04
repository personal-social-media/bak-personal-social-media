# frozen_string_literal: true

RSpec.shared_context "api_messages_create" do
  let(:documentation_title) { "Create message" }
  let(:documentation_unescaped_url) { "/api/messages" }
  let(:documentation_id) { :create }
  let(:documentation_params) do
    {
      message: {
        remote_id: {
          type: :id
        },
        message_type: {
          type: :string,
          variants: Message.message_types
        },
        signature: {
          type: :signature
        },
        payload: {
          message: {
            type: :string
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
