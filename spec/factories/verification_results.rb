# frozen_string_literal: true

# == Schema Information
#
# Table name: verification_results
#
#  id                :bigint           not null, primary key
#  percentage_status :integer          default(0), not null
#  remote_type       :string           not null
#  result            :text             default({}), not null
#  status            :string           default("running"), not null
#  subject_type      :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  peer_info_id      :bigint           not null
#  remote_id         :string           not null
#  subject_id        :bigint
#
# Indexes
#
#  index_verification_results_on_peer_info_id                 (peer_info_id)
#  index_verification_results_on_remote_id_and_remote_type    (remote_id,remote_type) UNIQUE
#  index_verification_results_on_subject_id_and_subject_type  (subject_id,subject_type) UNIQUE WHERE ((subject_id IS NOT NULL) AND (subject_type IS NOT NULL))
#
# Foreign Keys
#
#  fk_rails_...  (peer_info_id => peer_infos.id)
#
FactoryBot.define do
  factory :verification_result do
    remote_type { :post }
    sequence :remote_id do |n|
      n
    end

    before(:create) do |r|
      r.subject ||= create(:feed_item)
      r.peer_info ||= create(:peer_info)
    end
  end
end
