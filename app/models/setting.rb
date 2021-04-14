# frozen_string_literal: true

# == Schema Information
#
# Table name: settings
#
#  id                :bigint           not null, primary key
#  ui_sidebar_opened :boolean          default(TRUE), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Setting < ApplicationRecord
  attr_accessor :request, :browser

  def ui_sidebar_opened_helper
    return @ui_sidebar_opened_helper if defined? @ui_sidebar_opened_helper
    return @ui_sidebar_opened_helper = false if browser.device.mobile?
    @ui_sidebar_opened_helper = ui_sidebar_opened
  end
end
