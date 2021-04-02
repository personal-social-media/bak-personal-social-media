# frozen_string_literal: true

module CacheCommentsService
  class CreateCacheComment
    extend Memoist
    attr_reader :params, :comment
    def initialize(params)
      @params = params
    end

    def call!
      CacheComment.transaction do
        @comment = CacheComment.create!(create_params)
        album_title = "Comments"
        uploaded_files_params = params[:uploaded_files]

        if uploaded_files_params.present?
          uploaded_files = UploadsService::HandleMultipleUpload.new(uploaded_files_params).call!
          elements_options = { is_private: false }
          album_options = { album_name: album_title, album_manual_upload: false }
          AttachmentsService::Attach.new(comment, uploaded_files, elements_options: elements_options, album_options: album_options).call!
        else
          comment.sync_create
        end
      end

      comment
    end

    def create_params
      params.except(:uploaded_files)
    end

    memoize def subject
      return nil unless %w(FeedItem).include?(params[:subject_type])
      FeedItem.find_by(id: params[:subject_id])
    end

    memoize def peer_info
      PeerInfo.find_by!(id: params[:peer_info_id])
    end
  end
end

# module CacheCommentsService
#   class CreateCacheComment
#     class Error < Exception; end
#     include IdentityService::SignedRequest
#     extend Memoist
#
#     attr_reader :create_params
#     def initialize(create_params)
#       @create_params = create_params
#     end
#
#     def call!
#       return if existing_record.present?
#
#       response = HTTP.timeout(timeout).headers(signed_headers(url)).post(url, json: body)
#       raise Error, "bad server response: #{response.status} => #{response.body}" if response.status > 399
#
#       remote_id = JSON.parse(response.body.to_s).dig("comment", "id")
#
#       CacheComment.create!(subject: subject, payload: payload, remote_id: remote_id, peer_info: peer_info,
#                            payload_subject_type: payload_subject_type, payload_subject_id: payload_subject_id)
#     end
#
#     private
#       def timeout
#         10
#       end
#
#       def body
#         {
#           comment: {
#             subject_id: payload_subject_id,
#             subject_type: payload_subject_type,
#             parent_comment_id: parent_comment_id,
#             payload: payload,
#             signature: SignaturesService::Sign.new(payload.to_json).call!
#           }
#         }
#       end
#
#       def url
#         "https://#{peer_info.ip}/api/comments"
#       end
#
#       def existing_record
#         CacheComment.find_by(payload_subject_id: payload_subject_id, payload_subject_type: payload_subject_type)
#       end
#
#       memoize def subject
#         FeedItem.find_by(uid: payload_subject_id) if %w(post story).include?(payload_subject_type)
#       end
#
#       def payload_subject_type
#         create_params[:payload_subject_type]
#       end
#
#       def payload_subject_id
#         create_params[:payload_subject_id]
#       end
#
#       def payload
#         create_params[:payload]
#       end
#
#       def parent_comment_id
#         create_params[:parent_comment_id]
#       end
#
#   end
# end
