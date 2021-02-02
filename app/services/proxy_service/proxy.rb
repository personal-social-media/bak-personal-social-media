module ProxyService
  class Proxy
    attr_reader :target_server
    def initialize(target_server, method, path, body)
      @target_server = target_server
    end

    def call!

    end
  end
end