# frozen_string_literal: true

RSpec.shared_context "cache_comments_create_documentation" do
  let(:documentation_title) { "Create a new cache comment" }
  let(:documentation_unescaped_url) { "/client/cache_comments/upload" }
  let(:documentation_id) { :create }
  let(:documentation_params) do
    {
      cache_comment: {
        subject_type: {
          type: :string,
          optional: true,
          variants: %w(FeedItem)
        },
        subject_id: {
          type: :id,
          optional: true
        },
        parent_comment_id: {
          type: :uid,
          optional: true
        },
        payload_subject_type: {
          type: :string,
          variants: CacheComment.payload_subject_types
        },
        payload_subject_id: {
          type: :uid
        },
        peer_info_id: {
          type: :id,
        },
        payload: {
          message: {
            type: :string
          },
        },
        uploaded_files: [
          {
            ".name": "a.png",
            ".path": sample_image_tmp,
            ".md5": "md5"
          }
        ]
      }
    }
  end
end
