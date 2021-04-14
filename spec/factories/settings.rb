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
FactoryBot.define do
  factory :setting do
    ui_sidebar_opened { false }
  end
end
