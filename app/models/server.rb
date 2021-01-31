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
class Server < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :role, presence: true
  validates :ip, presence: true, format: { with: Regexp.union(Resolv::IPv4::Regex, Resolv::IPv6::Regex) }

  str_enum :role, %i(web_server load_balancer database storage redis)
end
