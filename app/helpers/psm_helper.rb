# frozen_string_literal: true

module PsmHelper
  def psm_button(type = :primary, **options)
    type_color = case type
                 when :primary
                   "bg-yellow-500 hover:bg-yellow-400"
                 else
                   raise "invalid color"
    end

    default_classes = "px-2 px-4 #{type_color} rounded shadow border border-solid border-gray-200 text-white font-bold"
    passed_classes = options[:class]
    options[:class] = passed_classes ? "#{default_classes} #{passed_classes}" : default_classes

    content_tag "button", **options do
      yield
    end
  end

  def psm_rounded(**options)
    default_classes = "bg-yellow-500 hover:bg-yellow-400 rounded-full h-8 w-8 flex justify-center items-center cursor-pointer"
    passed_classes = options[:class]
    options[:class] = passed_classes ? "#{passed_classes} #{default_classes}" : default_classes

    content_tag "div", **options do
      yield
    end
  end

  def settings
    return @settings if defined? @settings
    @settings = Setting.first.tap do |s|
      next if s.blank?
      s.request = request
      s.browser = browser
    end
  end

  def mobile?
    browser.device.mobile?
  end
end
