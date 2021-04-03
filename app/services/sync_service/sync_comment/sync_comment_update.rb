# frozen_string_literal: true

module SyncService
  class SyncComment
    class SyncCommentUpdate < BaseSync
      attr_reader :comment, :request, :create_service

      def initialize(comment)
        @comment = comment
        @create_service = SyncComment.new(comment)
      end

      def call_update!
        update_comment!
        @request = make_request
        check_response(request)
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
          "https://#{comment.peer_info.ip}/api/comments/#{comment.remote_id}"
        end

        def update_comment!
          comment.payload[:images] = images.map! { |i| get_variants_for_image(i) }
          comment.payload[:videos] = videos.map! { |v| get_variants_for_video(v) }

          comment.generate_signature!
        end

        def body
          {
            comment: {
              payload: comment.payload,
              signature: comment.signature
            }
          }.to_json
        end

        delegate :get_variants_for_image, :get_variants_for_video, :images, :videos, to: :create_service
    end
  end
end
