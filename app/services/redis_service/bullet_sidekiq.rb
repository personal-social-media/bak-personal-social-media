# frozen_string_literal: true

module RedisService
  class BulletSidekiq
    def call(_worker, _job, _queue)
      Bullet.profile do
        yield
      end
    end
  end
end
