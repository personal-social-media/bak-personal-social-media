# frozen_string_literal: true

RSpec.shared_context "cache_comments_create_documentation" do
  let(:documentation_title) { "Create a new cache comment" }
  let(:documentation_unescaped_url) { "/client/cache_comments/upload" }
  let(:documentation_id) { :create }
  let(:documentation_params) do
    {
      cache_comment: {
        payload_subject_type: {
          type: :string
        },
        payload_subject_id: {
          type: :string
        },
        payload: {
          message: {
            type: :string
          },
          subject_type: "FeedItem",
          subject_id: feed_item.id,
          parent_comment_id: nil,
          images: [
            {
              type: :image,
              desktop: "https://example.com/a.jpg",
              mobile: "https://example.com/a.jpg",
              thumbnail: "https://example.com/a.jpg",
            }
          ],
          videos: [
            {
              type: :video,
              original: "https://example.com/a.mp4",
              short: "https://example.com/a.mp4",
              original_screenshot: "https://example.com/a.jpg",
              thumbnail_screenshot: "https://example.com/a.jpg",
            }
          ]
        },
      }
    }
  end
end
