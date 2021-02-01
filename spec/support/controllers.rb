# frozen_string_literal: true

module ControllersHelper
  def login
    allow_any_instance_of(described_class).to receive(:current_user).and_return(profile)
  end

  def profile
    @profile ||= create(:profile)
  end
end

RSpec.configure do |config|
  config.include ControllersHelper, type: :controller
end
