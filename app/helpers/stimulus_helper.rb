# frozen_string_literal: true

module StimulusHelper
  def stimulus_controller(tag, name, data: {}, **options)
    data[:controller] = __format_stimulus_string(name)

    content_tag tag, data: data, **options do
      yield if block_given?
    end
  end

  def stimulus_action(tag, actions, data: {}, **options)
    actions = [actions] unless actions.is_a?(Array)

    actions.map! do |name|
      __format_stimulus_string(name)
    end

    data[:action] = actions.join(" ")
    content_tag tag, data: data, **options do
      yield if block_given?
    end
  end

  def stimulus_target(tag, controller, target_name, data: {}, **options)
    controller = __format_stimulus_string(controller)
    target_name = __format_stimulus_string(target_name)

    data["#{controller}-target"] = target_name

    content_tag tag, data: data, **options do
      yield if block_given?
    end
  end

  def __format_stimulus_string(str)
    str.to_s.gsub("/", "--").gsub("_", "-").squish
  end
end
