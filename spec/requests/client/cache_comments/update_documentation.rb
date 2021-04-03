# frozen_string_literal: true

RSpec.shared_context "cache_comments_update_documentation" do
  let(:documentation_title) { "Updates a cache comment" }
  let(:documentation_information) { "It only syncs remotely when 'payload' or 'uploaded_files' is present" }
  let(:documentation_unescaped_url) { "/client/cache_comments/upload" }
  let(:documentation_id) { :update }
  let(:documentation_params) do
    {
      cache_comment: {
        like_count: {
          type: :number,
          optional: true
        },
        love_count: {
          type: :number,
          optional: true
        },
        wow_count: {
          type: :number,
          optional: true
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
