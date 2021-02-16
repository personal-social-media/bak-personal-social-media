# frozen_string_literal: true

module PageHelper
  def render_not_found
    render template: "static/not_found"
  end
end
