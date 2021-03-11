# frozen_string_literal: true

# == Schema Information
#
# Table name: reactions
#
#  id            :bigint           not null, primary key
#  reaction_type :string           not null
#  subject_type  :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  peer_info_id  :bigint
#  subject_id    :bigint           not null
#
# Indexes
#
#  index_reactions_on_peer_info_id_and_subject_id  (peer_info_id,subject_id) UNIQUE
#  index_reactions_on_subject                      (subject_type,subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (peer_info_id => peer_infos.id)
#
require "rails_helper"

RSpec.describe Reaction, type: :model do
  let(:current_peer_info) { create(:peer_info, friend_ship_status: :self) }

  describe "callbacks" do
    describe "before_update" do
      describe "private update_count!" do
        subject { create(:reaction) }
        let(:subject_record) { subject.subject }

        it "updates the counts" do
          current_peer_info
          subject
          subject_record.reload
          expect(subject_record.like_count).to eq(1)

          subject.update!(reaction_type: :love)
          subject_record.reload

          expect(subject_record.like_count).to eq(0)
          expect(subject_record.love_count).to eq(1)
        end
      end
    end
  end
end
