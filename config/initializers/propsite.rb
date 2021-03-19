return unless Rails.env.development?

ActionController::Base.instance_exec do
  before_action do
    Prosopite.scan
  end

  after_action do
    Prosopite.finish
  end
end