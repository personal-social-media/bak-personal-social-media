# frozen_string_literal: true

module SyncService
  class SyncComment < BaseSync
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
      SyncMessageUpdate.new(comment).call_update!
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
        comment.payload.merge!({
          images: images.map! { |i| ImageFilePresenter.new(i, stubbed_request).render },
          videos: videos.map! { |i| ImageFilePresenter.new(i, stubbed_request).render },
        })
        comment.payload[:subject_type] = payload_subject_type
        comment.payload[:subject_id] = payload_subject_id
        comment.payload[:parent_comment_id] = parent_comment_id
        comment.generate_signature!
      end

      def images
        comment.attached_files.select(&:image?).map!(&:attachment)
      end

      def videos
        comment.attached_files.select(&:video?).map!(&:attachment)
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

      memoize def stubbed_request
        OpenStruct.new.tap do |r|
          r.headers = {
            "Client" => "desktop"
          }
        end
      end

      delegate_missing_to :comment
  end
end
