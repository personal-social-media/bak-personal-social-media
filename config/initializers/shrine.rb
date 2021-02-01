unless Rails.env.test?
  require "shrine/storage/file_system"

  uploads_root = Rails.env.production? ? Rails.root.join("../storage") : "public"

  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new(uploads_root, prefix: "uploads/cache"), # temporary
    store: Shrine::Storage::FileSystem.new(uploads_root, prefix: "uploads"),       # permanent
  }
end

Shrine.plugin :activerecord
Shrine.plugin :backgrounding
Shrine.plugin :cached_attachment_data
Shrine.plugin :data_uri
Shrine.plugin :determine_mime_type
Shrine.plugin :restore_cached_data
Shrine.plugin :store_dimensions
Shrine.plugin :validation_helpers
Shrine.plugin :versions
Shrine.plugin :determine_mime_type, analyzer: :marcel

Shrine.logger = Rails.logger