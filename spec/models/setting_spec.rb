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
require "rails_helper"

RSpec.describe Setting, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
