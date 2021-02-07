# frozen_string_literal: true
ENV["THOR_SILENCE_DEPRECATION"] = "TRUE"
Dir["#{File.dirname(__FILE__)}/.build/thor/**/*.rb"].each { |file| require file }
