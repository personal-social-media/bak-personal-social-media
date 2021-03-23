# frozen_string_literal: true

module DocumentationService
  class ValidateDocumentation
    class Error < Exception; end
    attr_reader :spec_ctx
    def initialize(spec_ctx)
      @spec_ctx = spec_ctx
    end

    def call!
      check_request_header
      check_controller
      check_documentation_parent_title
      check_documentation_usage
      check_documentation_parent_id
      check_documentation_usage

      check_documentation_title
      check_documentation_unescaped_url
      check_url
      check_documentation_id
      check_documentation_params
    end

    private
      def check_request_header
        validate_present(request.method, "HTTP method")
      end

      def validate_present(value, name)
        return if value.present?
        raise Error, "#{name} is missing"
      end

      def validate_present_let(value, name)
        return unless value.nil?
        raise Error, "let(:#{name}) is missing, please define it"
      end

      def method_missing(symbol, *_args)
        name = symbol.to_s
        if /^check_/.match?(name)
          field = name.gsub("check_", "")
          return validate_present_let(send(field), field)
        end

        begin
          spec_ctx.instance_exec { self.send(symbol) }
        rescue NoMethodError
          nil
        end
      end
  end
end
