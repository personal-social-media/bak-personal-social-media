# frozen_string_literal: true

module DocumentationService
  class DocumentationRecord
    attr_reader :spec_ctx, :result
    def initialize(spec_ctx)
      @spec_ctx = spec_ctx
    end

    def save!
      build_result
      FileUtils.mkdir_p([directory])

      return write_result unless File.exist?(file_path)

      if true
        write_result
      end
    end

    def build_result
      return if result.present?
      @result = {
        parent: {
          id: documentation_parent_id,
          controller: controller,
          title: documentation_parent_title,
          usage: documentation_usage
        },
        child:  {
          id: documentation_id,
          title: documentation_title,
          params: documentation_params,
          unescaped_url: documentation_unescaped_url,
          url: url,
          method: request.method,
          body: body,
          json: format_saved_hash(json)
        }
      }
    end

    def body
      b = request.body.read
      return b if b.blank?
      format_saved_hash(JSON.parse(b))
    end

    def directory
      @directory ||= Rails.root.join("spec/documentation/#{documentation_parent_id}").to_s
    end

    def format_saved_hash(hash)
      return hash if hash.blank?
      hash.deep_transform_values do |value|
        if is_date?(value)
          next "2020-01-01T00:00:00+00:00"
        end
        value
      end
    end

    def is_date?(value)
      Date.parse(value)
    rescue Exception
      false
    end

    def file_path
      directory + "/#{documentation_id}.json"
    end

    def write_result
      File.open(file_path, "w") do |f|
        f.write(JSON.pretty_generate(result))
      end
    end

    def method_missing(symbol, *_args)
      spec_ctx.instance_exec { self.send(symbol) }
    rescue NoMethodError
      nil
    end
  end
end