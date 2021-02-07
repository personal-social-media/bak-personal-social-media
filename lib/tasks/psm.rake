# frozen_string_literal: true

namespace :psm do
  desc "Generate private and public key"
  task generate_keys: :environment do
    service = SetupService::GenerateKeys.new.make_dir
    unless service.check?
      raise "keys already exist"
    end
    service.generate_keys.write_keys!
    p "keys generated"
  end

  desc "Renew ssl"
  task renew_ssl: :environment do
    ZeroSslService::Renew.new.call!
  end
end
