class ProxyController < ActionController::Base
  def index
    target_server = request.headers["Target-Server"]
    para = params.permit!
    body = request.request_parameters

    result = ProxyService::Proxy.new(target_server, request.method, para[:proxy_rails_path], body).call!

    render text: result.body.to_s, status: result.status, content_type: "application/json"
  rescue TimeoutError
    head 408
  rescue HTTP::ConnectionError
    head 502
  end
end