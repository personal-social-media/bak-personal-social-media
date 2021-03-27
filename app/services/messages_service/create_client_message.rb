# frozen_string_literal: true

module MessagesService
  class CreateClientMessage
    attr_reader :params, :message, :conversation
    def initialize(params, conversation)
      @params = params.merge(conversation: conversation, message_owner: :self, read: true)
      @conversation = conversation
    end

    def call!
      Message.transaction do
        @message = Message.create!(params.except(:uploaded_files))
        album_title = "Messages"
        uploaded_files_params = params[:uploaded_files]

        if uploaded_files_params.present?
          uploaded_files = UploadsService::HandleMultipleUpload.new(uploaded_files_params).call!
          elements_options = { is_private: true }
          album_options = { album_name: album_title, album_manual_upload: false }
          AttachmentsService::Attach.new(message, uploaded_files, elements_options: elements_options, album_options: album_options).call!
        else
          message.sync_create
        end
      end

      message
    end
  end
end
