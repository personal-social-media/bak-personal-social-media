# frozen_string_literal: true

# == Schema Information
#
# Table name: servers
#
#  id         :bigint           not null, primary key
#  ip         :string           not null
#  name       :string           not null
#  role       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Server, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
