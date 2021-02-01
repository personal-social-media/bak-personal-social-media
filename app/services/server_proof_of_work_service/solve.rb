# frozen_string_literal: true

module ServerProofOfWorkService
  class Solve
    include IdentityService::SignedRequest

    attr_reader :sign_string, :multiply

    def initialize(params)
      @sign_string = params[:sign_string]
      @multiply = params[:multiply]
    end

    def call!
      {
        multiply: handle_multiply,
        sign_string: handle_sign_string
      }
    end

    private
      def handle_multiply
        multiply.map(&:to_i).reject(&:zero?).inject(:*)
      end

      def handle_sign_string
        Base64.encode64(private_key.sign(OpenSSL::Digest::SHA256.new, sign_string))
      end
  end
end
