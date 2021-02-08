# frozen_string_literal: true

module SetupService
  class DownloadCities
    def call!
      existing_dir = Rails.root.join("vendor/cities")
      return if Dir.exist?(existing_dir)

      `wget https://s3-us-west-2.amazonaws.com/cities-gem/cities.tar.gz -O /tmp/cities.tar.gz`
      `tar -xzf /tmp/cities.tar.gz -C #{Rails.root.join("vendor")}`
    end
  end
end
