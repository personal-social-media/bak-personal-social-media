SecureHeaders::Configuration.default do |config|
  config.cookies = {
    secure: true,
    httponly: true,
    samesite: {
      lax: true
    }
  }
  config.x_frame_options = "DENY"
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = "1; mode=block"
  config.x_download_options = "noopen"
  config.referrer_policy = %w(origin-when-cross-origin strict-origin-when-cross-origin)
  config.csp = {
    # "meta" values. these will shape the header, but the values are not included in the header.
    preserve_schemes: true, # default: false. Schemes are removed from host sources to save bytes and discourage mixed content.
    disable_nonce_backwards_compatibility: true, # default: false. If false, `unsafe-inline` will be added automatically when using nonces. If true, it won't. See #403 for why you'd want this.

    # directive values: these values will directly translate into source directives
    default_src: %w('none'),
    base_uri: %w('self'),
    child_src: %w('self'),
    font_src: %w('self' data: fonts.gstatic.com),
    form_action: %w('self'),
    frame_ancestors: %w('none'),
    img_src: %w('self' blob: data: *),
    manifest_src: %w('self'),
    media_src: %w('self' blob: data: *),
    object_src: %w('self'),
    script_src: %w('self'),
    script_src_elem: %w('self' 'unsafe-inline'),
    script_src_attr: %w('self'),
    style_src: %w('self' unpkg.com cdnjs.cloudflare.com fonts.googleapis.com),
    style_src_elem: %w('self' 'unsafe-inline' unpkg.com cdnjs.cloudflare.com fonts.googleapis.com),
    style_src_attr: %w('self' 'unsafe-inline'),
    worker_src: %w('self'),
    connect_src: %w('self' *)
  }

  if Rails.env.production?
    config.hsts = "max-age=#{1.week.to_i}"
    config.csp.merge!({
      upgrade_insecure_requests: true,
      block_all_mixed_content: true,
      preserve_schemes: false,
      script_src_elem: %w('self'),
      style_src_elem: %w('self' unpkg.com cdnjs.cloudflare.com fonts.googleapis.com)
    })
  end
end