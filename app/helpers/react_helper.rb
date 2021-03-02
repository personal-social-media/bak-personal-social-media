# frozen_string_literal: true

module ReactHelper
  def format_data_for_react(hash)
    hash.deep_transform_keys! { |k| k.to_s.camelize(:lower) }
  end
end
