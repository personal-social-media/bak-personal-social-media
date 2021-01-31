# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/.build/thor/**/*.rb"].each { |file| require file }
