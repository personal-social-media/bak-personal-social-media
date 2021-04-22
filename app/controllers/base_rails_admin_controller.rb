# frozen_string_literal: true

# internal use
class BaseRailsAdminController < ActionController::Base
  include BulletHelper

  around_action :skip_bullet, if: -> { defined?(Bullet) }
end
