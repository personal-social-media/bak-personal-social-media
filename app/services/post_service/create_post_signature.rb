# frozen_string_literal: true

module PostService
  class CreatePostSignature
    attr_reader :post
    def initialize(post)
      @post = post
    end

    def call!
      SignaturesService::Sign.new(payload.to_json).call!
    end

    def payload
      post.as_json(only: default_fields).tap do |json|
        images = post.attached_files.select(&:image?).map!(&:attachment)
        json[:images] = images.map! { |i| ImageFilePresenter.new(i, request).render }

        videos = post.attached_files.select(&:video?).map!(&:attachment)
        json[:videos] = videos.map! { |v| VideoFilePresenter.new(v, request).render }
      end
    end

    def default_fields
      %i(uid content like_count location_name love_count mood wow_count created_at signature)
    end

    def request
      OpenStruct.new.tap do |r|
        r.headers = {
          "Client" => "desktop"
        }
      end
    end
  end
end
