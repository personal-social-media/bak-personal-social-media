# frozen_string_literal: true

module SyncService
  class SyncComment < BaseSync
    include SyncService::MediaVariants
    attr_reader :comment, :request

    def initialize(comment)
      @comment = comment
    end

    def call_create!
      update_comment!
      @request = make_request
      check_response(request)
      json = JSON.parse(request.response.body)
      remote_id = json.dig("comment", "id")
      comment.update!(remote_id: remote_id)
    end

    def call_update!
      SyncCommentUpdate.new(comment).call_update!
    end

    def images
      comment.attached_files.select(&:image?).map!(&:attachment)
    end

    def videos
      comment.attached_files.select(&:video?).map!(&:attachment)
    end

    private
      def make_request
        hydra = Typhoeus::Hydra.hydra
        Typhoeus::Request.new(url, method: :post, headers: default_headers(url).merge(json_headers), body: body).tap do |r|
          hydra.queue(r)
          hydra.run
        end
      end

      def url
        "https://#{comment.peer_info.ip}/api/comments"
      end

      def update_comment!
        comment.payload[:subject_id] = payload_subject_id
        comment.payload[:subject_type] = payload_subject_type
        comment.payload[:parent_comment_id] = parent_comment_id
        comment.payload[:images] = images.map! { |i| get_variants_for_image(i) }
        comment.payload[:videos] = videos.map! { |v| get_variants_for_video(v) }

        comment.generate_signature!
      end

      def body
        {
          comment: {
            subject_id: payload_subject_id,
            subject_type: payload_subject_type,
            parent_comment_id: parent_comment_id,
            payload: payload,
            signature: signature
          }
        }.to_json
      end

      delegate_missing_to :comment
  end
end
