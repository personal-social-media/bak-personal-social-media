# frozen_string_literal: true

return unless Rails.env.test?

Rails.application.config.after_initialize do
  ActionController::Base.module_exec do
    class << self
      alias_method :default_before_action, :before_action

      def before_action(*args, &block)
        new_filters = args.map do |arg|
          next arg unless arg.is_a?(Symbol) || arg.is_a?(String)
          ->(ctrl) do
            called_list = ctrl.instance_variable_get("@before_action_list_called") || []
            ctrl.send(arg)
            called_list << arg
            ctrl.instance_variable_set("@before_action_list_called", called_list.uniq)
          end
        end
        default_before_action(*new_filters, &block)
      end
    end
  end
end
